App.Image = DS.Model.extend({
  fileUrl: DS.attr('string'),
  annotations: DS.hasMany('annotation'),
  highlights: DS.hasMany('highlight')
})