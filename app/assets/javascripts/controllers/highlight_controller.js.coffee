App.HighlightController = Ember.ObjectController.extend({
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

  actions: {
    removeHighlight: ->
      model = @get('model')
      model.deleteRecord()
      model.save()
  }

  onWindowResize: ->
    @computeDimension()

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
  ).property('computedTop').
    property('computedLeft').
    property('computedWidth').
    property('computedHeight')

  willDestroy: ->
    $(window).off("resize.#{@ns()}")
})