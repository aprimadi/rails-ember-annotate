# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  file       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Image < ActiveRecord::Base
  mount_uploader :file, ImageUploader

  has_many :annotations
  has_many :highlights
end
