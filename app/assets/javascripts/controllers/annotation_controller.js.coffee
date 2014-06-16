App.AnnotationController = Ember.ObjectController.extend({
  actions: {
    editAnnotation: ->
      @set('edit', true)

    acceptChanges: ->
      model = @get('model')
      model.save()
  }

  annotationStyle: (() ->
    top = @get('top') * $('#canvas img').height()
    left = @get('left') * $('#canvas img').width()
    return "top: #{top}px; left: #{left}px;"
  )
})