App.Moveable = Ember.View.extend({
  tagName: 'div'

  mouseDown: (e) ->
    @get('controller').send('mouseDowned', e.clientX, e.clientY)

  mouseUp: (e) ->
    @get('controller').send('mouseUpped', e.clientX, e.clientY)

  dragStart: (e) ->
    e.preventDefault()
})

