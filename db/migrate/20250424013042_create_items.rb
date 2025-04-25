class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.references :category, null: false
      t.string :name, null: false
      t.boolean :completed, default: false, null: false
      t.boolean :repeating, default: false, null: false
      t.timestamps
    end
  end
end
