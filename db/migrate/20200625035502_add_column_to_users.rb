class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :lang, :Integer, default: 0
  end
end
