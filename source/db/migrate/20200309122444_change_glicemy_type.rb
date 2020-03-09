class ChangeGlicemyType < ActiveRecord::Migration[5.2]
  def change
    change_column :measurements, :glicemy, :integer, limit: 2
  end
end
