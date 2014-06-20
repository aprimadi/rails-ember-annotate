App.EditAnnotationView = Ember.TextArea.extend({
  attributeBindings: ['style']

  didInsertElement: ->
    this.$().focus()
    this.$().autogrow()

  mouseMove: (e) ->
    this.$().autogrow()

  mouseDown: (e) ->
    e.stopPropagation()

  mouseUp: (e) ->
    e.stopPropagation()
})

Ember.Handlebars.helper('edit-annotation', App.EditAnnotationView)