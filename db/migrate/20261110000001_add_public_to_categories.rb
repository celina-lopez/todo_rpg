class AddPublicToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :is_public, :boolean, default: false, null: false
  end
end
