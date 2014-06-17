#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require handlebars
#= require ember
#= require ember-data
#= require dropzone
#
#= require_self
#= require rails_ember_annotate

# for more details see: http://emberjs.com/guides/application/
window.App = Ember.Application.create()

App.ApplicationAdapter = DS.ActiveModelAdapter.extend({})

Ember.TextField.reopen({
  attributeBindings: ['style']
});

$(document).ready ->
  # Enable tooltip on mouseenter
  $('[data-toggle=tooltip]').on 'mouseenter', ->
    $(@).tooltip('show')

  # Upload picture change handler
  $('#upload-picture [type=file]').on 'change', ->
    $('#upload-picture').submit()
