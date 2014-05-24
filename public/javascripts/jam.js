$(function() {
	var socket;

	function init() {
//		connect();

		
		$("#drum").unbind().on('click', drum);
		$("#connect").unbind().on('click', connect);
	}

	function connect() {
		var server = $("#server").val();
		console.log("connecting to " + server)
		socket = io.connect(server);


		socket.on('disconnect', function () {
   			console.log('client disconnected');
		});

		socket.on('debug', function (data) {
   			console.log('debug: ' + data);
		});
	}

	function drum() {
		var msg = 'beep boop bap';
		socket.emit('audio', { audio: msg });
		console.log(msg)
	}
	
	init(); 

}
)



