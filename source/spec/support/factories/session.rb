# frozen_string_literal: true

FactoryBot.define do
  factory :session, class: 'Session' do
    user
  end
end
