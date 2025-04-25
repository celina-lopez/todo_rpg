# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  character  :integer          default("girl"), not null
#  theme      :integer          default("default"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_rooms_on_user_id  (user_id)
#
require "test_helper"

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
