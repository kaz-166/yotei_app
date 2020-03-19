class AddAbstractToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :abstract, :text
  end
end
