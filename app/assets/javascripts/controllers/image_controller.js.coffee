App.ImageController = Ember.ObjectController.extend({
  init: ->
    $(window).on('resize.image_controller', $.proxy(@onWindowResize, @))

  onWindowResize: (e) ->
    height = $(window).height() - $('#toolbar').outerHeight(true)
    console.log(height)
    @set('height', height)

  canvasStyle: (() ->
    console.log(@get('height'))
    return "height: #{@get('height')}px;"
  ).property('height')

  willDestroy: ->
    $(window).off('resize.image_controller')
})
