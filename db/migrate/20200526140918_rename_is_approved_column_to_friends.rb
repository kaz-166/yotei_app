class RenameIsApprovedColumnToFriends < ActiveRecord::Migration[5.2]
  def change
    rename_column :friends, :IsApproved, :isapproved
  end
end
