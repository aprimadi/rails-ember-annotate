App.Moveable = Ember.View.extend({
  tagName: 'div'

  mouseDown: (e) ->
    @get('controller').send('mouseDowned', e.clientX, e.clientY)
    return false

  mouseUp: (e) ->
    @get('controller').send('mouseUpped', e.clientX, e.clientY)
    return false

  dragStart: (e) ->
    e.preventDefault()
})

