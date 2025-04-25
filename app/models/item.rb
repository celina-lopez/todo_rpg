# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  completed   :boolean          default(FALSE), not null
#  name        :string           not null
#  repeating   :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
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
