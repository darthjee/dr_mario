# frozen_string_literal: true

class LoginController < ApplicationController
  include OnePageApplication
  include LoggedUser

  protect_from_forgery except: [:create]

  before_action :save_session, only: :create

  def create
    render json: User::Decorator.new(user)
  end

  private

  def user
    @user ||= User.login(login_params)
  end

  def login_params
    params.require(:login).permit(:login, :password)
          .to_h.symbolize_keys
  end
end
