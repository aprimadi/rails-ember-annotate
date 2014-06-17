class HighlightSerializer < ActiveModel::Serializer
  attributes :id, :top, :left, :width, :height
end