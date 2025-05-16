# == Schema Information
#
# Table name: rooms
#
#  id              :bigint           not null, primary key
#  character       :integer          default("female_youth"), not null
#  decreased_level :boolean          default(FALSE), not null
#  level           :integer          default(0), not null
#  theme           :integer          default("default"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :bigint           not null
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

  POSITIVE_ROOM_PHRASES = [
    "An empty room full of potential... and echoes.",
    "Oh now you have a bed… it's a start...",
    "Chair's here! You still don't have a table but we all gotta start somewhere.",
    "A tiny rug tiptoes in. So soft, so sweet!",
    "You got your first computer! Maybe now you can ship in some more furniture",
    "A potted plant appears! ...can you see it?",
    "Hey, now you can do laundry in the comfort of your own home!",
    "This is starting to look cozy! Good job!",
    "I don't think I ever want to step outside again.",
    "Oh you finally started to pay attention to that other room",
    "Time to take a relaxing bath, then curl up and watch some TV",
    "A wonderful dream home! Hopefully there are no breakins"
  ]

  NEGATIVE_ROOM_PHRASES = [
    "Those theives stole everything!",
    "Not like you had much to begin with...",
    "Those theives took your computer :(",
    "Those theives unmade your bed!...now why would they do that...",
    "Those theives took your cat furniture! They must pay!!",
    "How did those theives take that bathtub? It was custom made!",
    "Why did the theives drain the bathtub...",
    "Those theives took the plant but left the pot???",
    "Those theives took your rare sword! We will never find it again!",
    "Those theives are taking all your decorations! We gotta stop them!",
    "Those theives stole the golden dragon!"
  ]

  def increment_level!(by = 1)
    self.level = [ level + by, 12 ].min
    save!
  end

  def decrement_level!(by = 1)
    self.level = [ level - by, 0 ].max
    save!
  end
end
