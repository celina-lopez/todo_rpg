# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  character  :integer          default("girl"), not null
#  level      :integer          default(0), not null
#  theme      :integer          default("default"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_rooms_on_user_id  (user_id)
#
class Room < ApplicationRecord
  belongs_to :user
  has_many :furnitures, dependent: :destroy

  enum theme: {
    default: 0
  }

  enum character: {
    girl: 0
  }
end
