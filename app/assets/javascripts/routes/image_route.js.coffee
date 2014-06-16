App.ImageRoute = Ember.Route.extend({
  model: ->
    matches = window.location.pathname.match(/^\/images\/([0-9a-z]+)$/)
    image_id = matches[1]
    return @store.find('image', image_id)

  renderTemplate: (controller) ->
    @render('image/index', {controller: controller})
})