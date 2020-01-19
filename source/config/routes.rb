# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users, only: [] do
    resources :measurements, only: [:index, :show, :create]
  end
end
