class AddFurnitureLocation < ActiveRecord::Migration[8.0]
  def change
    remove_column :furnitures, :coordinate, :integer
    remove_column :furnitures, :type, :integer
    add_column :furnitures, :furniture_type, :integer, default: 0, null: false
    add_column :furnitures, :coordinate_x, :float, default: 0, null: false
    add_column :furnitures, :coordinate_y, :float, default: 0, null: false
  end
end
