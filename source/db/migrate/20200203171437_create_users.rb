# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :salt, null: false

      t.timestamps

      t.index :email, unique: true
      t.index :login, unique: true
    end
  end
end
