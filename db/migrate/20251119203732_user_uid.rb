class UserUid < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :uid, :string, null: false, default: -> { "gen_random_uuid()" }
    add_index :users, :uid, unique: true
  end
end
