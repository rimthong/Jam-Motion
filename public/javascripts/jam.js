$(function() {
	$("#owl-example").owlCarousel({singleItem:true});
	
	var socket;
	var isAccelActive;
	var isDebouncing = false;
	var debouncer;

	var x = 0, y = 0, z=0;

	function init() {
		$("#instruments img").on('click', function() { jam($(this).attr('id'),$(this).data('note')) });
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
				
				if (absol > 5) {
				console.log(absol);
					$.debounce( 250, true, log_foo )
					/*if (!isDebouncing) {
						jam("snare");
						sendAccel(x,y,z,absol); 
						isDebouncing = true
						debouncer = setTimeout(function() {isDebouncing = false}, 1000);
					}*/
				} else {
					//isDebouncing = false;
					//clearTimeout(debouncer);
				}
				
				
			}, 25);
		} 
	}

function log_foo() {
	console.log("foo");
}
	function sendAccel(x, y, z, absol) {
		if (isAccelActive) {
			//$("#accel").text(absol);
			var accelObj = { "accel" : { "x":x, "y":y, "z":z , "abs": absol} }
			//socket.emit('audio', accelObj);
			console.log("sent accel " + accelObj)
		}
	}

	function jam(instr, note) {
		socket.emit('audio', { "instrument": instr, "note": note });
		console.log("sent audio " + msg)
	}
	
	init(); 

}
)



