# frozen_string_literal: true

class Measurement < ApplicationRecord
  validates :glicemy, :time, :date, presence: true

  belongs_to :user
end
