# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string           not null
#  color      :integer          default("0"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#

class Category < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  validates_presence_of :name
  validates_presence_of :color
  before_create :set_color

  COLORS = [
    "#cb4023",
    "#f48858",
    "#6dd2d9",
    "#3da566",
    "#81ade0",
    "#5bca84",
    "#ffcf1c",
    "#dca6bf"
  ]

  def set_color
    self.color = rand(COLORS.length)
  end

  def color_class
    "bg-[#{COLORS[color]}]"
  end
end
