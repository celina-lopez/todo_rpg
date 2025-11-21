# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  hush_key   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uid        :string           not null
#
# Indexes
#
#  index_users_on_hush_key  (hush_key) UNIQUE
#  index_users_on_uid       (uid) UNIQUE
#

class User < ApplicationRecord
  has_one :room, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :furnitures, through: :room
  has_many :items, through: :categories


  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"


  validates_presence_of :name, :hush_key
  validates_uniqueness_of :hush_key

  before_validation :generate_hush_key, on: :create
  after_create :create_room
  before_create :generate_short_uid

  def generate_hush_key
    self.hush_key = SecureRandom.hex(16) if self.hush_key.blank?
  end

  def create_room
    Room.create!(user: self)
  end

  def generate_short_uid
    self.uid = SecureRandom.hex(5)
  end
end
