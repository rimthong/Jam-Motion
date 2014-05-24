var socket = io.connect('http://localhost');
socket.emit('audio', { audio: 'beep boop bap' });
