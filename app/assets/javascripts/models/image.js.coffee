App.Image = DS.Model.extend({
  fileUrl: DS.attr('string'),
  annotations: DS.hasMany('annotations'),
  highlights: DS.hasMany('highlights')
})