class CreateMeasurements < ActiveRecord::Migration[5.2]
  def change
    create_table :measurements do |t|
      t.integer  :glicemy, limit: 1
      t.date     :date
      t.time     :time
      t.timestamps
    end
  end
end
