# == Schema Information
#
# Table name: furnitures
#
#  id         :bigint           not null, primary key
#  coordinate :integer          not null
#  type       :integer          default("bed")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint           not null
#
# Indexes
#
#  index_furnitures_on_room_id  (room_id)
#
class Furniture < ApplicationRecord
  belongs_to :room
  validates_presence_of :coordinate

  enum :type, {
    bed: 0
  }
end
