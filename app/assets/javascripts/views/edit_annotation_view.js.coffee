App.EditAnnotationView = Ember.TextArea.extend({
  attributeBindings: ['style']

  didInsertElement: ->
    this.$().focus()
    this.$().autogrow()

  mouseMove: (e) ->
    this.$().autogrow()
})

Ember.Handlebars.helper('edit-annotation', App.EditAnnotationView)