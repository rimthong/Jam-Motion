socket = io.connect('http://localhost')
socket.emit('audio', { audio: 'beep boop bap' })

kick = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'kick' })

snare = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'snare' })

loop1 = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'loop1', command: 'start' })

loop1stop = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'loop1', command: 'stop' })

loop2 = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'loop2', command: 'start' })

loop2stop = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'loop2', command: 'stop' })

hbase = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'hbase' })

hhat = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'hhat' })

bass = (n, player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'bass', note: n })

fx = (n) ->
  socket.emit('audio', { player: player, instrument: 'fx', note: n })

juno = (note) ->
  socket.emit('audio', { player: player, instrument: 'juno', note: note })

cymbal = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'cymbal'})

duophonic = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'duophonic' })

duophonic5 = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'duophonic5' })

sineStart = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'sine', command: 'start' })

sineStop = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'sine', command: 'stop' })

guitar = (note, player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'guitar', note: note })

percussion = (note, player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'percussion', note: note })

bassLoop = (note, player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'bass-loop', note: note })

consoleBass = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'console-bass'})

drumLoop = (note, player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'drum-loop', note: note})

stopBass = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'bass-loop', note: 'stop'})

stopDrum = (player = 'anon') ->
  socket.emit('audio', { player: player, instrument: 'drum-loop', note: 'stop'})

socket.on 'debug', (data) ->
  console.log("Received:", data)
