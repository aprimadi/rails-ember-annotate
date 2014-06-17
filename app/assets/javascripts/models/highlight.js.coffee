App.Highlight = DS.Model.extend({
  image: DS.belongsTo('image'),
  top: DS.attr('number'),
  left: DS.attr('number'),
  width: DS.attr('number'),
  height: DS.attr('number')
})