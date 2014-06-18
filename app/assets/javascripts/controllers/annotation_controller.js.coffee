App.AnnotationController = Ember.ObjectController.extend({
  needs: 'image'

  ns: ->
    guid = Math.random().toString(36).substring(7)
    @_namespace ||= "annotation_controller_#{guid}"
    @_namespace

  init: ->
    $(window).on("resize.#{@ns()}", $.proxy(@onWindowResize, @))

    # HACK: Necessary because '#canvas img' is not yet inserted to DOM yet
    # which cause the position computation to be off
    setTimeout(=>
      @computePosition()
    , 100)
    @computePosition()

    image_controller = @get('controllers.image')
    image_controller.on('canvasMouseMoved', @, @onCanvasMouseMoved)

  actions: {
    editAnnotation: ->
      @set('edit', true)

    acceptChanges: ->
      @set('edit', false)

      model = @get('model')
      if model.get('text').trim() == ''
        model.deleteRecord()
        model.save()
      else
        model.save()

    mouseDowned: (x, y) ->
      @set('dragging', true)

    mouseUpped: (x, y) ->
      @set('dragging', false)
      @savePosition()
  }

  onWindowResize: ->
    @computePosition()

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

  computePosition: ->
    top = @get('top') * $('#canvas img').height()
    left = @get('left') * $('#canvas img').width()
    @set('computedTop', top)
    @set('computedLeft', left)

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

  annotationStyle: (() ->
    top = @get('computedTop')
    left = @get('computedLeft')
    zindex = if @get('dragging') then 10000 else 2
    return "top: #{top}px; left: #{left}px; z-index: #{zindex}"
  ).property('computedTop', 'computedLeft', 'dragging')

  isEditing: (() ->
    @get('edit')
  ).property('edit')

  willDestroy: ->
    $(window).off("resize.#{@ns()}")

    image_controller = @get('controllers.image')
    image_controller.off('canvasMouseMoved', @, @onCanvasMouseMoved)
})