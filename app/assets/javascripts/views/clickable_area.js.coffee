App.ClickableArea = Ember.View.extend({
  click: (e) ->
    @get('controller').send('clickArea', e.clientX, e.clientY)
})