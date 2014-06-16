class ImageSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :file_url

  has_many :annotations
  has_many :highlights

  def file_url
    object.file.url
  end

end
