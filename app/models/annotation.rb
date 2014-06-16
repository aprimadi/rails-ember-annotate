class Annotation
  include MongoMapper::EmbeddedDocument

  key :text, String
  key :top, Float
  key :left, Float
  key :font_size, Integer
end