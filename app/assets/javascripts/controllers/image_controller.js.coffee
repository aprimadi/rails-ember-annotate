App.ImageController = Ember.ObjectController.extend({
  init: ->
    $(window).on('resize.image_controller', $.proxy(@onWindowResize, @))
    @computeCanvasHeight()

  actions:
    toggleHighlightMode: ->
      if @get('toolmode') == 'highlight'
        @set('toolmode', null)
      else
        @set('toolmode', 'highlight')

    toggleAnnotateMode: ->
      if @get('toolmode') == 'annotate'
        @set('toolmode', null)
      else
        @set('toolmode', 'annotate')

    clickArea: (x, y) ->
      if @get('toolmode') == 'highlight'
      else if @get('toolmode') == 'annotate'
        @addAnnotation(x, y)

  addAnnotation: (x, y) ->
    left = x / $('#canvas img').width()
    top = y / $('#canvas img').height()

    console.log(left)
    console.log(top)

    # Create annotation
    annotation = @store.createRecord('annotation', {
      image: @get('model'),
      text: 'Test',
      left: left,
      top: top
    })

    annotation.save()

  onWindowResize: (e) ->
    @computeCanvasHeight()

  computeCanvasHeight: ->
    height = $(window).height() - $('#toolbar').outerHeight(true)
    @set('height', height)

  canvasStyle: (() ->
    return "height: #{@get('height')}px;"
  ).property('height')

  inHighlightMode: (() ->
    @get('toolmode') == 'highlight'
  ).property('toolmode')

  inAnnotateMode: (() ->
    @get('toolmode') == 'annotate'
  ).property('toolmode')

  annotations: (->
    window.model = @get('model')
    window.store = @store
    console.log(@get('model'))
    []
  ).property('model.annotations')

  willDestroy: ->
    $(window).off('resize.image_controller')
})
