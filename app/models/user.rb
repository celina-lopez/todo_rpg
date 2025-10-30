# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  hush_key   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_hush_key  (hush_key) UNIQUE
#

class User < ApplicationRecord
  has_one :room, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :furnitures, through: :room
  has_many :items, through: :categories

  validates_presence_of :name, :hush_key
  validates_uniqueness_of :hush_key

  before_validation :generate_hush_key, on: :create
  after_create :create_room

  def generate_hush_key
    self.hush_key = SecureRandom.hex(16) if self.hush_key.blank?
  end

  def create_room
    Room.create!(user: self)
  end
end
