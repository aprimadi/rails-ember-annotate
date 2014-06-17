# == Schema Information
#
# Table name: annotations
#
#  id         :integer          not null, primary key
#  image_id   :integer
#  text       :text
#  top        :float
#  left       :float
#  font_size  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Annotation < ActiveRecord::Base
  belongs_to :image
end
