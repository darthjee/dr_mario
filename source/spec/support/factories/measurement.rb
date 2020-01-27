# frozen_string_literal: true

FactoryBot.define do
  factory :measurement, class: Measurement do
    glicemy { 100 }
    date    { Date.today }
    time    { Time.now }
  end
end
