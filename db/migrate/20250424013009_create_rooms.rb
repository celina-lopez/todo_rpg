class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.references :user, null: false
      t.integer :theme, default: 0, null: false
      t.integer :character, default: 0, null: false
      t.integer :level, default: 0, null: false
      t.timestamps
    end
  end
end
