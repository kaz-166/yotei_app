class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.integer :event_id
      t.integer :user_id
      t.string :integer

      t.timestamps
    end
  end
end
