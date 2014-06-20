$ ->
  console.log 'jam ready'


  $("#owl-example").owlCarousel(singleItem: true)

  init = ->

    $("#instruments img").on 'click', ->
      instrument = $(@).parent().data('instrument')
      note = $(@).data('note')
      $("#instruments .active").removeClass("active")
      $(@).addClass("active")

    $("#connect").unbind().on('click', connect)

    #init accel
    if window.DeviceMotionEvent != undefined
      window.ondevicemotion = accelCalculation

    $("#server").val(window.location.hostname)


  #Socket management
  connect = ->
    server = $("#server").val()
    console.log("connecting to #{server}")
    socket = io.connect(server)

    socket.on 'connect', ->
      console.log('connected')
      $("#connector").slideUp()
      $("#instruments").slideDown()
      isAccelActive = true

    socket.on 'disconnect', ->
      isAccelActive = false
      console.log('client disconnected')
      $("#connector").slideDown()
      $("#instruments").slideUp()

    socket.on 'debug', (data) ->
      console.log("debug: #{data}")


  #Accelerometer function to debounce
  accelCalculation = (e) ->
      x = e.acceleration.x
      y = e.acceleration.y
      z = e.acceleration.z

      absol = Math.sqrt(x*x + y*y + z*z)
      
      if absol > 10
        if x > 0
          subinstrument = "kick"
        else
          subinstrument = "snare"
        moveThrottled()

  moveThrottled = _.throttle( jam, 250, { trailing: false })

  jam = ->
      $("#msg").fadeIn(100).fadeOut(200)

      if instrument
        socket.emit('audio', { "instrument" : instrument, "note" : note, "id" : myGUID })
