class AddColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :open_range, :integer, default: 0
  end
end
