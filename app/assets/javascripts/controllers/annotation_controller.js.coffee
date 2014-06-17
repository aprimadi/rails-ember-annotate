App.AnnotationController = Ember.ObjectController.extend({
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

  actions: {
    editAnnotation: ->
      @set('edit', true)

    acceptChanges: ->
      @set('edit', false)

      model = @get('model')
      model.save()
  }

  onWindowResize: ->
    @computePosition()

  computePosition: ->
    top = @get('top') * $('#canvas img').height()
    left = @get('left') * $('#canvas img').width()
    @set('computedTop', top)
    @set('computedLeft', left)

  annotationStyle: (() ->
    top = @get('computedTop')
    left = @get('computedLeft')
    return "top: #{top}px; left: #{left}px;"
  ).property('computedTop').property('computedLeft')

  isEditing: (() ->
    @get('edit')
  ).property('edit')

  willDestroy: ->
    $(window).off("resize.#{@ns()}")
})