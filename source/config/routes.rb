# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'home#show', as: :home

  resources :users, only: [] do
    resources :measurements, only: %i[index show create new]

    collection do
      resources :login, only: [:create] do
        get '/' => :check, on: :collection
      end
    end
  end
end
