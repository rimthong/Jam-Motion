#Dependencies
express = require 'express'
routes = require './routes'
test = require './routes/test'
http = require 'http'
path = require 'path'
Player = require 'player'
debounce = require 'debounce'
exec = require('child_process').exec #Experimental

#setup express server
app = express()
server = require('http').createServer(app)
io = require('socket.io').listen(server, {log: false})

#configs
app.set('port', process.env.PORT || 3000)
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')
app.use(express.favicon())
app.use(express.logger('dev'))
app.use(express.bodyParser())
app.use(express.methodOverride())
app.use(app.router)
app.use(express.static(path.join(__dirname, 'public')))
if 'development' is app.get('env')
  app.use(express.errorHandler())

#routes
app.get('/', routes.index)
app.get('/test', test.test)

#Instrument sampling
duophonic = new Player './instruments/synth01_duophonic.mp3'
duophonic5 = new Player './instruments/synth01_duophonic_X5.mp3'
hbase = new Player './instruments/H_base_05.mp3'
hhat = new Player './instruments/DRUM_1SEC/H_closedhat_01_1SEC.mp3'
kick = new Player './instruments/DRUM_1SEC/kick_01_1SEC.mp3'
arp = new Player './instruments/ARP_1SEC.mp3'
snare = new Player './instruments/DRUM_1SEC/snarerim01_1SEC.mp3'
loop1 = new Player './instruments/LOOP_BEAT_1.mp3'
loop2 = new Player './instruments/LOOP_DRUM_BASS_1.mp3'
bass1 = new Player './instruments/BASS_RIFFS/BASS_RIFF_1.mp3'
bass2 = new Player './instruments/BASS_RIFFS/BASS_RIFF_2.mp3'
bass3 = new Player './instruments/BASS_RIFFS/BASS_RIFF_3.mp3'
juno_c = new Player './instruments/ARPS/JUNO_C.mp3'
juno_e = new Player './instruments/ARPS/JUNO_e.mp3'
juno_g = new Player './instruments/ARPS/JUNO_g.mp3'
fx1 = new Player './instruments/FX/FX_1.mp3'
fx2 = new Player './instruments/FX/FX_2.mp3'
fx3 = new Player './instruments/FX/FX_3.mp3'
cymbal = new Player './instruments/CYMBAL.mp3'
guitar = {}
guitar.a = new Player './instruments/indie/HIT_GUITAR_1.mp3'
guitar.b = new Player './instruments/indie/HIT_GUITAR_2.mp3'
guitar.c = new Player './instruments/indie/HIT_GUITAR_3.mp3'
percussion = {}
percussion.a = new Player './instruments/indie/HIT_PERC_1.mp3'
percussion.b = new Player './instruments/indie/HIT_PERC_2.mp3'
percussion.c = new Player './instruments/indie/HIT_PERC_3.mp3'
bassLoop = {}
bassLoop.a = new Player './instruments/indie/LOOP_BASS_1.mp3'
bassLoop.b = new Player './instruments/indie/LOOP_BASS_2.mp3'
drumLoop = {}
drumLoop.a = new Player './instruments/indie/LOOP_DRUM_1.mp3'
drumLoop.b = new Player './instruments/indie/LOOP_DRUM_2.mp3'

#Loop events
isPlaying = ->
  bassLoop.isRepeating or drumLoop.isRepeating

tick = ->
  setTimeout ->
    if bassLoop.isRepeating then bassLoop[bassLoop.note].play()
    if drumLoop.isRepeating then drumLoop[drumLoop.note].play()
  , 0

loopTick = debounce(tick, 700)

drumLoop.a.on 'playend', ->
  loopTick()

drumLoop.a.on 'error', (err) ->
  console.log "Drum A error:", err

drumLoop.b.on 'playend', ->
  loopTick()

drumLoop.b.on 'error', (err) ->
  console.log "Drum B error:", err

bassLoop.a.on 'playend', ->
  loopTick()

bassLoop.a.on 'error', (err) ->
  console.log "Bass A error:", err

bassLoop.b.on 'playend', ->
  loopTick()

bassLoop.b.on 'error', (err) ->
  console.log "Bass B error:", err

#socketIO
io.sockets.on 'connection', (socket) ->

  #Process audio request
  socket.on 'audio', (message) ->

    switch message.instrument

      #Loop tracks
      when 'loop1'
        if message.command is 'start' then loop1.play()
        if message.command is 'stop' then loop1.stop()

      when 'loop2'
        if message.command is 'start' then loop2.play()
        if message.command is 'stop' then loop2.stop()

      #Single note instruments
      when 'arp' then arp.play()

      when 'cymbal' then cymbal.play()

      when 'kick' then kick.play()

      when 'snare' then snare.play()

      when 'hbase' then hbase.play()

      when 'hhat' then hhat.play()

      #Complex instruments
      when 'bass'
        switch message.note
          when 1 then bass1.play()
          when 2 then bass2.play()
          else bass3.play()

      when 'fx'
        switch message.note
          when 1 then fx1.play()
          when 2 then fx2.play()
          else fx3.play()

      when 'juno'
        switch message.note
          when 'c', 'C' then juno_c.play()
          when 'e', 'E' then juno_e.play()
          else juno_g.play()

      when 'guitar'
        guitar[message.note].play()

      when 'percussion'
        percussion[message.note].play()

      when 'bass-loop'
        if message.note is 'stop'
          bassLoop.isRepeating = false
        else
          unless isPlaying()
            bassLoop.isRepeating = true
            bassLoop.note = message.note
            bassLoop[message.note].play()
          else
            bassLoop.note = message.note
            bassLoop.isRepeating = true

      when 'console-bass'
        alwaysPlay()

      when 'drum-loop'
        if message.note is 'stop'
          drumLoop.isRepeating = false
        else
          unless isPlaying()
            drumLoop.isRepeating = true
            drumLoop.note = message.note
            drumLoop[message.note].play()
          else
            drumLoop.note = message.note
            drumLoop.isRepeating = true

alwaysPlay = ->
  exec 'play ./instruments/indie/LOOP_BASS_1.mp3 repeat 9999', ->
    console.log 'phew, tired.'

#Actually start the server
server.listen app.get('port'), ->
  console.log "We're jamming on port #{app.get('port')}"
