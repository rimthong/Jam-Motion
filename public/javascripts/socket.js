var socket = io.connect('http://localhost');
socket.emit('audio', { audio: 'beep boop bap' });

kick = function(){
  socket.emit('audio', { instrument: 'kick' });
};

snare = function(){
  socket.emit('audio', { instrument: 'snare' });
};

loop1 = function(){
  socket.emit('audio', { instrument: 'loop1' });
};

loop2 = function(){
  socket.emit('audio', { instrument: 'loop2' });
};

socket.on('debug', function(data){
    console.log("Received:", data);
}) 
