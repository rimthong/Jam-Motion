Player = Backbone.Model.extend
  initialize: ->
    console.log "Player joined the game"

Players = Backbone.Collection.extend
  model: Player

PlayerView = Backbone.View.extend
  initialize: ->
    @render()

  template: Haml(
    """
    .player
      %h1=name
      %i.fa.fa-volume-off.fa-5x
      %h2=instrument
    """)

  render: ->
    @$el.html(@template(@model.attributes))
    @

$ ->

  p1 = new Player
    name: 'Alex'
    instrument: 'Guitar'

  p1View = new PlayerView
    el: ($ '.player-view')
    model: p1
