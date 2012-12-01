class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :university
      t.integer :points, null: false, default: 0
      t.string :device_token
      t.string :fb_uuid
      t.string :fb_token

      t.timestamps

    end
    add_index :users, :email, unique: true
  end
end
