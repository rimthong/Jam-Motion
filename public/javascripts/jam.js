$(function() {
	$("#owl-example").owlCarousel({singleItem:true});
	
	var socket;
	var isAccelActive;
	var isDebouncing = false;
	var debouncer;

	var x = 0, y = 0, z=0;

  var command = ''

  // wow: 
  var myGUID = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
      return v.toString(16);
  });
	function init() {
		$("#instruments img").on('click', function() { instrument = $(this).parent().data('instrument'); note = $(this).data('note'); $("#instruments .active").removeClass("active"); $(this).addClass("active") }); 
		$("#connect").unbind().on('click', connect);

		initAccel();

		$("#server").val(window.location.hostname);
	}

	function connect() {
		// $("#server").blur(); doesn't work
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


  accelCalculation = function(e) {
      x = e.acceleration.x;
      y = e.acceleration.y;
      z = e.acceleration.z;

      /*if ( e.rotationRate ) {
        document.getElementById("rotationAlpha").innerHTML = e.rotationRate.alpha;
        document.getElementById("rotationBeta").innerHTML = e.rotationRate.beta;
        document.getElementById("rotationGamma").innerHTML = e.rotationRate.gamma;
      }*/		

      var absol = Math.sqrt(x*x + y*y + z*z);
      
      if (absol > 5) {
        moveThrottled();
      }
    }

	moveThrottled = _.throttle( jam, 250, { trailing: false })

	function initAccel() {		
		if (window.DeviceMotionEvent != undefined) {
			window.ondevicemotion = accelCalculation;
		} 
	}


function jam() {
    $("#msg").fadeIn(100).fadeOut(200);

    //$("#accel").text(absol);
    //var accelObj = { "accel" : { "x" : x, "y" : y, "z" : z , "abs" : 1 } }
    // socket.emit('audio', accelObj);
    // console.log("sent accel " + accelObj)
    
    if (instrument) {
      socket.emit('audio', { "instrument" : instrument, "note" : note, "id" : myGUID });
      console.log("sent audio")
    }
}

	
	init(); 

}
)



