class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :hush_key, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
