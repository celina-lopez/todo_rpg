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
require "test_helper"

class FurnitureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
