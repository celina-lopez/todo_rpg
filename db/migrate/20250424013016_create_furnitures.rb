class CreateFurnitures < ActiveRecord::Migration[7.2]
  def change
    create_table :furnitures do |t|
      t.references :room, null: false
      t.integer :type, default: 0
      t.integer :coordinate, null: false
      t.timestamps
    end
  end
end
