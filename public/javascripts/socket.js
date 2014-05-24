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

hbase = function(){
  socket.emit('audio', { instrument: 'hbase' });
};

hhat = function(){
  socket.emit('audio', { instrument: 'hhat' });
};

duophonic = function(){
  socket.emit('audio', { instrument: 'duophonic' });
};

duophonic5 = function(){
  socket.emit('audio', { instrument: 'duophonic5' });
};

sineStart = function(){
  socket.emit('audio', { instrument: 'sine', command: 'start' });
};

sineStop = function(){
  socket.emit('audio', { instrument: 'sine', command: 'stop' });
};

socket.on('debug', function(data){
    console.log("Received:", data);
}) 
