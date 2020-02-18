# frozen_string_literal: true

class LoginController < ApplicationController
  include LoggedUser

  protect_from_forgery except: [:create]

  def create
    render json: User::Decorator.new(logged_user)
  end
end
