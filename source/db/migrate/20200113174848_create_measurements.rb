# frozen_string_literal: true

class CreateMeasurements < ActiveRecord::Migration[5.2]
  def change
    create_table :measurements do |t|
      t.integer  :glicemy, null: false, limit: 1
      t.date     :date,    null: false
      t.time     :time,    null: false
      t.timestamps
    end
  end
end
