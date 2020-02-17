class Session < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.datetime :expiration
      t.timestamps
    end
  end
end
