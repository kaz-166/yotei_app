class AddApprovalToFriends < ActiveRecord::Migration[5.2]
  def change
    add_column :friends, :IsApproved, :boolean, default: false
  end
end
