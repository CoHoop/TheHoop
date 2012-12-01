class CreateMicrohoops < ActiveRecord::Migration
  def change
    create_table :microhoops do |t|
      t.integer :user_id,    null: false
      t.text    :content,    null: false
      t.integer :votes,      null: false, default: 0
      t.string  :location,   null: false
      t.boolean :is_meeting, null: false, default: false

      t.timestamps
    end
    add_index :microhoops, [:user_id, :created_at]
  end
end
