App.Canvas = Ember.View.extend({
  click: (e) ->
    @get('controller').send('canvasClicked', e.offsetX, e.offsetY)

  mouseMove: (e) ->
    @get('controller').send('canvasMouseMoved', e.clientX, e.clientY)
})