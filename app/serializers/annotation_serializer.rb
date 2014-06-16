class AnnotationSerializer < ActiveModel::Serializer
  attributes :id, :text, :top, :left
end