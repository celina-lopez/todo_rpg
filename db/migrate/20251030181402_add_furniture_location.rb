class AddFurnitureLocation < ActiveRecord::Migration[8.0]
  def change
    remove_column :furnitures, :coordinate, :integer
    add_column :furnitures, :coordinate_x, :float, default: 0
    add_column :furnitures, :coordinate_y, :float, default: 0
  end
end
