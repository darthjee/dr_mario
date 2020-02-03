# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    sequence(:login) { |n| "user-#{n}" }
    email            { "#{login}@email.com" }
    password         { 'myPass' }
  end
end
