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
require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
