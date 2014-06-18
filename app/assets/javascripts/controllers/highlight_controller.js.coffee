App.HighlightController = Ember.ObjectController.extend({
  needs: 'image'

  ns: ->
    guid = Math.random().toString(36).substring(7)
    @_namespace ||= "highlight_controller_#{guid}"
    @_namespace

  init: ->
    $(window).on("resize.#{@ns()}", $.proxy(@onWindowResize, @))

    # HACK: Necessary because '#canvas img' is not yet inserted to DOM yet
    # which cause the dimension computation to be off
    setTimeout(=>
      @computeDimension()
    , 100)
    @computeDimension()

    image_controller = @get('controllers.image')
    image_controller.on('canvasMouseMoved', @, @onCanvasMouseMoved)

  actions: {
    removeHighlight: ->
      model = @get('model')
      model.destroyRecord()

    mouseDowned: (x, y) ->
      @set('dragging', true)
      @set('startDragX', x)
      @set('startDragY', y)
      @set('endDragX', x)
      @set('endDragY', y)

    mouseUpped: (x, y) ->
      @set('dragging', false)
      if @get('startDragX') != @get('endDragX') || @get('startDragY') != @get('endDragY')
        @savePosition()
  }

  onWindowResize: ->
    @computeDimension()

  onCanvasMouseMoved: (x, y) ->
    if @get('dragging')
      @set('endDragX', x)
      @set('endDragY', y)
      @updatePosition()
    else
      @set('origComputedTop', @get('computedTop'))
      @set('origComputedLeft', @get('computedLeft'))
      @set('startDragX', x)
      @set('startDragY', y)

  updatePosition: ->
    top = @get('origComputedTop') + @get('endDragY') - @get('startDragY')
    left = @get('origComputedLeft') + @get('endDragX') - @get('startDragX')
    @set('computedTop', top)
    @set('computedLeft', left)

  savePosition: ->
    top = @get('computedTop') / $('#canvas img').height()
    left = @get('computedLeft') / $('#canvas img').width()

    model = @get('model')
    model.set('top', top)
    model.set('left', left)
    model.save()

  computeDimension: ->
    canvasHeight = $('#canvas img').height()
    canvasWidth = $('#canvas img').width()

    top = @get('top') * canvasHeight
    left = @get('left') * canvasWidth
    width = @get('width') * canvasWidth
    height = @get('height') * canvasHeight

    @set('computedTop', top)
    @set('computedLeft', left)
    @set('computedWidth', width)
    @set('computedHeight', height)

  highlightStyle: (() ->
    top = @get('computedTop')
    left = @get('computedLeft')
    width = @get('computedWidth')
    height = @get('computedHeight')

    return "top: #{top}px; left: #{left}px; width: #{width}px; height: #{height}px;"
  ).property('computedTop', 'computedLeft', 'computedWidth', 'computedHeight')

  willDestroy: ->
    $(window).off("resize.#{@ns()}")

    image_controller = @get('controllers.image')
    image_controller.off('canvasMouseMoved', @, @onCanvasMouseMoved)
})