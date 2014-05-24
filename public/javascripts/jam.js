$(function() {
	$("#owl-example").owlCarousel({singleItem:true});
	
	var socket;

	function init() {
		$("#drum").on('click', function() { jam("drum") });
		$("#guit").on('click', function() { jam("guit") });
		$("#loop1").on('click', function() { jam("loop1") });
		$("#connect").unbind().on('click', connect);
	}

	function connect() {
		var server = $("#server").val();
		console.log("connecting to " + server)
		socket = io.connect(server);

		socket.on('connect', function() {
			console.log('connected');
			$("#connector").slideUp()
			$("#instruments").slideDown();
		})

		socket.on('disconnect', function () {
   			console.log('client disconnected');
			$("#connector").slideDown()
			$("#instruments").slideUp();
		});

		socket.on('debug', function (data) {
   			console.log('debug: ' + data);
		});
	}

	function jam(msg) {
		socket.emit('audio', { "instrument": msg });
		console.log("sent audio " + msg)
	}
	
	init(); 

}
)



