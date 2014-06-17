# == Schema Information
#
# Table name: highlights
#
#  id         :integer          not null, primary key
#  image_id   :integer
#  top        :float
#  left       :float
#  width      :float
#  height     :float
#  created_at :datetime
#  updated_at :datetime
#

class Highlight < ActiveRecord::Base
  belongs_to :image
end
