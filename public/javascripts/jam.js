$(function() {
	$("#owl-example").owlCarousel({singleItem:true});
	
	var socket;
	var isAccelActive;
	var x = 0, y = 0, z=0;

	function init() {
		$("#hhat").on('click', function() { jam("hhat") });
		$("#kick").on('click', function() { jam("kick") });
		$("#snare").on('click', function() { jam("snare") });
		$("#loop1").on('click', function() { jam("loop1") });
		$("#loop2").on('click', function() { jam("loop2") });
		$("#connect").unbind().on('click', connect);

		initAccel();
	}

	function connect() {
		var server = $("#server").val();
		console.log("connecting to " + server)
		socket = io.connect(server);

		socket.on('connect', function() {
			console.log('connected');
			$("#connector").slideUp()
			$("#instruments").slideDown();
			isAccelActive = true
		})

		socket.on('disconnect', function () {
			isAccelActive = false
   			console.log('client disconnected');
			$("#connector").slideDown()
			$("#instruments").slideUp();
		});

		socket.on('debug', function (data) {
   			console.log('debug: ' + data);
		});
	}


	
	function initAccel() {		
		if (window.DeviceMotionEvent != undefined) {
			window.ondevicemotion = function(e) {
				e.preventDefault(); //disable shake undo

				x = e.acceleration.x;
				y = e.acceleration.y;
				z = e.acceleration.z;

				/*if ( e.rotationRate ) {
					document.getElementById("rotationAlpha").innerHTML = e.rotationRate.alpha;
					document.getElementById("rotationBeta").innerHTML = e.rotationRate.beta;
					document.getElementById("rotationGamma").innerHTML = e.rotationRate.gamma;
				}*/		
			}

			setInterval( function() {
				var absol = Math.sqrt(x*x + y*y + z*z);
				
				if (absol > 10) {
					sendAccel(x,y,z,absol);
				}
				
				
			}, 25);
		} 
	}


	function sendAccel(x, y, z, absol) {
		if (isAccelActive) {
			//$("#accel").text(absol);
			var accelObj = { "accel" : { "x":x, "y":y, "z":z , "abs": absol} }
			socket.emit('audio', accelObj);
			console.log("sent accel " + accelObj)
		}
	}

	function jam(msg) {
		socket.emit('audio', { "instrument": msg });
		console.log("sent audio " + msg)
	}
	
	init(); 

}
)



