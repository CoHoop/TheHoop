class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :microhoop_id
      t.integer :user_id
      t.text    :content
      t.integer :votes, null: false, default: 0

      t.timestamps
    end
    add_index :answers, [:user_id, :created_at]
    add_index :answers, [:microhoop_id, :created_at]
  end
end
