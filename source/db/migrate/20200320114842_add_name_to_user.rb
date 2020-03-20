class AddNameToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :name, :string, null: false, default: ""
    change_column :users, :name, :string, null: false, default: nil
  end

  def down
    remove_column :users, :name
  end
end
