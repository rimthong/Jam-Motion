Player = Backbone.Model.extend
  initialize: ->
    console.log "Player joined the game"

Players = Backbone.Collection.extend
  model: Player

PlayerView = Backbone.View.extend
  initialize: ->
    @render()
    @.on 'jam:play', (player, instrument) ->
      if @model.get('player') isnt player
        @model.set('player', player)
        @render()
      if @model.get('instrument') isnt instrument
        @model.set('instrument', instrument)
        @render()
      (@$ '.speaker').removeClass('fa-volume-off')
      (@$ '.speaker').addClass('fa-volume-up')
      setTimeout ->
        (@$ '.speaker').removeClass('fa-volume-up')
        (@$ '.speaker').addClass('fa-volume-down')
      , 1000
    @.on 'jam:stop', (player, instrument) ->
      (@$ '.speaker').removeClass('fa-volume-up')
      (@$ '.speaker').removeClass('fa-volume-down')
      (@$ '.speaker').addClass('fa-volume-off')

  template: Haml(
    """
    .player
      %h1.player-name=name
      %i.speaker.fa.fa-volume-off.fa-5x
      %h2.instrument=instrument
    """)

  render: ->
    @$el.html(@template(@model.attributes))
    @

$ ->
  socket = io.connect('http://localhost')
  p1 = new Player
    name: 'Alex'
    instrument: 'Guitar'

  p1View = new PlayerView
    el: ($ '.player-view')
    model: p1

  document.player = p1View

  socket.on 'play', (message) ->
    if message.instrument is 'guitar'
      document.player.trigger 'jam:play', message.player, message.instrument

  socket.on 'stop', (message) ->
    if message.instrument is 'guitar'
      document.player.trigger 'jam:stop', message.player, message.instrument

