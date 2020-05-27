class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.boolean :friends, :IsApproved, default: false

      t.timestamps
    end
  end
end
