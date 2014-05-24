var socket = io.connect('http://localhost');
socket.emit('audio', { audio: 'beep boop bap' });
socket.on('debug', function(data){
  console.log("Received:", data);
}) 
