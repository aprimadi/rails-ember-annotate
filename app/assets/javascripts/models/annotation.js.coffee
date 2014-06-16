App.Annotation = DS.Model.extend({
  image: DS.belongsTo('image'),
  top: DS.attr('number'),
  left: DS.attr('number'),
  text: DS.attr('string')
})