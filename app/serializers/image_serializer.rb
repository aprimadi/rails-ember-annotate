class ImageSerializer < ActiveModel::Serializer
  attributes :id, :file_url

  has_many :annotations
  has_many :highlights

  def file_url
    object.file.url
  end
end
