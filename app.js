
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
var loop1 = new Player('./instruments/LOOP_BEAT_1.mp3');

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
    loop1.play(function(err, loop1){
      console.log('loop');
    });
  });
  
});

server.listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
