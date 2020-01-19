# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'home#show', as: :home

  resources :users, only: [] do
    resources :measurements, only: %i[index show create]
  end
end
