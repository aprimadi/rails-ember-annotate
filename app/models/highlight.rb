class Highlight
  include MongoMapper::EmbeddedDocument

  key :top, Float
  key :left, Float
  key :width, Float
  key :height, Float
end