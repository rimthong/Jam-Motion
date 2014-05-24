var socket = io.connect('http://localhost');
socket.emit('audio', { audio: 'beep boop bap' });

kick = function(){
  socket.emit('audio', { instrument: 'kick' });
};

snare = function(){
  socket.emit('audio', { instrument: 'snare' });
};

loop1 = function(){
  socket.emit('audio', { instrument: 'loop1', command: 'start' });
};

loop1stop = function(){
  socket.emit('audio', { instrument: 'loop1', command: 'stop' });
};

loop2 = function(){
  socket.emit('audio', { instrument: 'loop2', command: 'start' });
};

loop2stop = function(){
  socket.emit('audio', { instrument: 'loop2', command: 'stop' });
};

hbase = function(){
  socket.emit('audio', { instrument: 'hbase' });
};

hhat = function(){
  socket.emit('audio', { instrument: 'hhat' });
};

bass = function(n){
  socket.emit('audio', { instrument: 'bass', note:n });
};

fx = function(n){
  socket.emit('audio', { instrument: 'fx', note:n });
};

juno = function(note){
  socket.emit('audio', { instrument: 'juno', note:note });
};

cymbal = function(){
  socket.emit('audio', { instrument: 'cymbal'});
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
