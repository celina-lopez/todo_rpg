# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  category_id :integer          not null
#  name        :string           not null
#  completed   :boolean          default("false"), not null
#  repeating   :boolean          default("false"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_items_on_category_id  (category_id)
#

class Item < ApplicationRecord
  belongs_to :category
  validates_presence_of :name

  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
end
