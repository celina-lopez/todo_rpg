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
    female_youth: 0,
    witch: 1,
    female_baker: 2,
    female_office_worker: 3,
    female_elder: 4,
    male_student1: 5,
    male_traditional: 6,
    male_punk: 7,
    male_casual: 8,
    female_trendy: 9,
    female_student: 10,
    gutty_chan: 11,
    male_youth: 12,
    male_business_man_old: 13,
    shiba_inu: 14,
    male_student: 15,
    male_business_man: 16,
    female_cafe_maid: 17,
    male_traffic_cop: 18
  }
end
