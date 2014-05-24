
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
var baudio = require('baudio');


//Init our instruments
var duophonic = new Player('./instruments/synth01_duophonic.mp3');
var duophonic5 = new Player('./instruments/synth01_duophonic_X5.mp3');
var hbase = new Player('./instruments/H_base_05.mp3');
var hhat = new Player('./instruments/DRUM_1SEC/H_closedhat_01_1SEC.mp3');
var kick = new Player('./instruments/DRUM_1SEC/kick_01_1SEC.mp3');
var arp = new Player('./instruments/ARP_1SEC.mp3');
var snare = new Player('./instruments/DRUM_1SEC/snarerim01_1SEC.mp3');
var loop1 = new Player('./instruments/LOOP_BEAT_1.mp3');
var loop2 = new Player('./instruments/LOOP_DRUM_BASS_1.mp3');
var bass1 = new Player('./instruments/BASS_NOTES/BASS_1SEC_NOTE1.mp3');
var bass2 = new Player('./instruments/BASS_NOTES/BASS_1SEC_NOTE2.mp3');
var bass3 = new Player('./instruments/BASS_NOTES/BASS_1SEC_NOTE3.mp3');
var juno_c = new Player('./instruments/ARPS/JUNO_C.mp3');
var juno_e = new Player('./instruments/ARPS/JUNO_e.mp3');
var juno_g = new Player('./instruments/ARPS/JUNO_g.mp3');
var cymbal = new Player('./instruments/CYMBAL.mp3');

var app = express();
var server = require('http').createServer(app);
var io = require('socket.io').listen(server, {log:false});

var n = 0;

var baseLine = 262

var b = baudio(function (t) {
    var x = Math.sin(t * baseline + Math.sin(n));
    n += Math.sin(t);
    return x;
});


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
      kick.play();
    }
    if(data.instrument == 'hbase'){
      hbase.play();
    }
    if(data.instrument == 'snare'){
      snare.play();
    }
    if(data.instrument == 'hhat'){
      hhat.play();
    }
    if(data.instrument == 'bass'){
      switch(data.note){
        case 1:
          bass1.play();
          break;
        case 2:
          bass2.play();
          break;
        default:
          bass3.play();
          break;
      }
    }
    if(data.instrument == 'juno'){
      switch(data.note){
        case 'c':
          juno_c.play();
          break;
        case 'e':
          juno_e.play();
          break;
        default:
          juno_g.play();
          break;
      }
    }
    if(data.instrument == 'loop2'){
      console.log('loop2');
      loop2.play(function(err, loop2){
        console.log('looped2');
      });
    }
    if(data.instrument == 'sine'){
      if(data.command == 'start'){
        b.play()
      }
      if(data.command == 'stop'){
        b.stop()
      }
    }
    if(data.instrument == 'arp'){
      arp.play(function(err, arp){
        console.log('arp');
      });
    }
    if(data.instrument == 'cymbal'){
      cymbal.play(function(err, cymbal){
        console.log('cymbal');
      });
    }
    if(data.instrument == 'duophonic5'){
      console.log('duo5');
      duophonic5.play(function(err, duophonic5){
        console.log('duo5');
      });
    }
  });
  
});

server.listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
