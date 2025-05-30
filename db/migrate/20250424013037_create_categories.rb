class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.integer :color, null: false, default: 0
      t.timestamps
    end
  end
end
