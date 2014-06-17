App.EditAnnotationView = Ember.TextField.extend({
  didInsertElement: ->
    this.$().focus()
})

Ember.Handlebars.helper('edit-annotation', App.EditAnnotationView)