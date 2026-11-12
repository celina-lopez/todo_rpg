class AddFurnitureTrackingToRooms < ActiveRecord::Migration[8.0]
  def change
    add_column :rooms, :furniture_level, :integer, default: 0, null: false
    add_column :rooms, :seen_level, :integer, default: 0, null: false
  end
end
