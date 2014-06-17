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
        @set('startDragging', false)

    toggleAnnotateMode: ->
      if @get('toolmode') == 'annotate'
        @set('toolmode', null)
      else
        @set('toolmode', 'annotate')

    canvasClicked: (x, y) ->
      if @get('toolmode') == 'highlight'
        @set('startDragging', !@get('startDragging'))
        if !@get('startDragging')
          @addHighlight()
        else
          # Record coordinate
          @set('startDragX', x)
          @set('startDragY', y)
          @set('endDragX', x)
          @set('endDragY', y)
      else if @get('toolmode') == 'annotate'
        @addAnnotation(x, y)

    canvasMouseMoved: (x, y) ->
      if @get('startDragging')
        @set('endDragX', x)
        @set('endDragY', y)

  addAnnotation: (x, y) ->
    left = x / $('#canvas img').width()
    top = y / $('#canvas img').height()

    return if left < 0 || left > 1
    return if top < 0 || top > 1

    # Create annotation
    annotation = @store.createRecord('annotation', {
      image: @get('model'),
      text: 'Double click to edit',
      left: left,
      top: top
    })

    annotation.save()

    @set('toolmode', null)

  addHighlight: ->
    top = Math.min(@get('startDragY'), @get('endDragY'))
    left = Math.min(@get('startDragX'), @get('endDragX'))
    width = Math.abs(@get('startDragX') - @get('endDragX'))
    height = Math.abs(@get('startDragY') - @get('endDragY'))

    relTop = top / $('#canvas img').height()
    relLeft = left / $('#canvas img').width()
    relWidth = width / $('#canvas img').width()
    relHeight = height / $('#canvas img').height()

    return if width == 0 || height == 0

    highlight = @store.createRecord('highlight', {
      image: @get('model'),
      left: relLeft,
      top: relTop,
      width: relWidth,
      height: relHeight
    })

    highlight.save()

    @set('toolmode', null)

  onWindowResize: (e) ->
    @computeCanvasHeight()

  computeCanvasHeight: ->
    height = $(window).height() - $('#toolbar').outerHeight(true)
    @set('height', height)

  canvasStyle: (() ->
    return "height: #{@get('height')}px;"
  ).property('height')

  highlightPointerStyle: (() ->
    top = Math.min(@get('startDragY'), @get('endDragY'))
    left = Math.min(@get('startDragX'), @get('endDragX'))
    width = Math.abs(@get('startDragX') - @get('endDragX'))
    height = Math.abs(@get('startDragY') - @get('endDragY'))
    return "top: #{top}px; left: #{left}px; width: #{width}px; height: #{height}px;"
  ).property('startDragX').
    property('startDragY').
    property('endDragX').
    property('endDragY')

  inHighlightMode: (() ->
    @get('toolmode') == 'highlight'
  ).property('toolmode')

  inAnnotateMode: (() ->
    @get('toolmode') == 'annotate'
  ).property('toolmode')

  annotations: (->
    window.model = @get('model')
    window.store = @store
    @get('model').get('annotations')
  ).property('model.annotations')

  showHighlightPointer: (() ->
    @get('startDragging')
  ).property('startDragging')

  willDestroy: ->
    $(window).off('resize.image_controller')
})
