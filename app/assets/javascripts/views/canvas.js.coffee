App.Canvas = Ember.View.extend({
  click: (e) ->
    @get('controller').send('canvasClicked', e.clientX, e.clientY)

  mouseMove: (e) ->
    @get('controller').send('canvasMouseMoved', e.clientX, e.clientY)

  mouseDown: (e) ->
    @get('controller').send('canvasMouseDowned', e.clientX, e.clientY)

  mouseUp: (e) ->
    @get('controller').send('canvasMouseUpped', e.clientX, e.clientY)

  dragStart: (e) ->
    e.preventDefault()
})