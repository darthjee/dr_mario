# frozen_string_literal: true

class AddUserToMeasurements < ActiveRecord::Migration[5.2]
  def up
    change_table :measurements do |t|
      t.integer :user_id, null: false, default: 1
    end

    change_column :measurements, :user_id, :integer, null: false, default: nil
  end

  def down
    remove_column :measurements, :user_id
  end
end
