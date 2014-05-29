socket = io.connect('http://localhost')
socket.emit('audio', { audio: 'beep boop bap' })

kick = ->
  socket.emit('audio', { instrument: 'kick' })

snare = ->
  socket.emit('audio', { instrument: 'snare' })

loop1 = ->
  socket.emit('audio', { instrument: 'loop1', command: 'start' })

loop1stop = ->
  socket.emit('audio', { instrument: 'loop1', command: 'stop' })

loop2 = ->
  socket.emit('audio', { instrument: 'loop2', command: 'start' })

loop2stop = ->
  socket.emit('audio', { instrument: 'loop2', command: 'stop' })

hbase = ->
  socket.emit('audio', { instrument: 'hbase' })

hhat = ->
  socket.emit('audio', { instrument: 'hhat' })

bass = (n) ->
  socket.emit('audio', { instrument: 'bass', note:n })

fx = (n) ->
  socket.emit('audio', { instrument: 'fx', note:n })

juno = (note) ->
  socket.emit('audio', { instrument: 'juno', note:note })

cymbal = ->
  socket.emit('audio', { instrument: 'cymbal'})

duophonic = ->
  socket.emit('audio', { instrument: 'duophonic' })

duophonic5 = ->
  socket.emit('audio', { instrument: 'duophonic5' })

sineStart = ->
  socket.emit('audio', { instrument: 'sine', command: 'start' })

sineStop = ->
  socket.emit('audio', { instrument: 'sine', command: 'stop' })

guitar = (note)->
  socket.emit('audio', { instrument: 'guitar', note:n })

percussion = (note)->
  socket.emit('audio', { instrument: 'percussion', note:n })

bassLoop = (note)->
  socket.emit('audio', { instrument: 'bass-loop', note:n })

drumLoop = (note)->
  socket.emit('audio', { instrument: 'drum-loop', note:n })

socket.on 'debug', (data) ->
  console.log("Received:", data)
