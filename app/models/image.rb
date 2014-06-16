class Image
  include MongoMapper::Document

  mount_uploader :file, ImageUploader

  key :file, String

  many :annotations
  many :highlights
end