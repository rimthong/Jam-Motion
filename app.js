
/**
 * Module dependencies.
 */

var express = require('express');
var routes = require('./routes');
var user = require('./routes/user');
var test = require('./routes/test');
var http = require('http');
var path = require('path');
var Player = require('player');


//Init our instruments
var duophonic = new Player('./instruments/synth01_duophonic.mp3');
var hbase = new Player('./instruments/H_base_05.mp3');
var kick = new Player('./instruments/kick_01.mp3');
var snare = new Player('./instruments/snarerim01.mp3');
var loop1 = new Player('./instruments/LOOP_BEAT_1.mp3');
var loop2 = new Player('./instruments/LOOP_DRUM_BASS_1.mp3');

var app = express();
var server = require('http').createServer(app);
var io = require('socket.io').listen(server, {log:false});

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);
app.get('/users', user.list);
app.get('/test', test.test);


io.sockets.on('connection', function(socket){

  socket.on('audio', function(data){
    console.log('audioData:', data)
    //TODO REMOVE THIS DEBUG
    socket.emit('debug', data);
    if(data.instrument == 'loop1'){
      console.log('starting loop');
      loop1.play(function(err, loop1){
        console.log('stop loop');
      });
    }
    if(data.instrument == 'kick'){
      console.log('kick!');
      kick.play(function(err, kick){
        console.log('kicked');
      });
    }
    if(data.instrument == 'snare'){
      console.log('snare!');
      snare.play(function(err, snare){
        console.log('snared');
      });
    }
    if(data.instrument == 'loop2'){
      console.log('snare!');
      loop2.play(function(err, loop2){
        console.log('snared');
      });
    }
  });
  
});

server.listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
