# == Schema Information
#
# Table name: furnitures
#
#  id           :integer          not null, primary key
#  room_id      :integer          not null
#  type         :integer          default("0")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  coordinate_x :float            default("0.0")
#  coordinate_y :float            default("0.0")
#
# Indexes
#
#  index_furnitures_on_room_id  (room_id)
#

class Furniture < ApplicationRecord
  belongs_to :room
  validates_presence_of :coordinate_x, :coordinate_y

  enum :type, {
    bed: 0
  }
end
