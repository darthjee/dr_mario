# frozen_string_literal: true

class LoginController < ApplicationController
  protect_from_forgery except: [:create]

  def create
    session = user.sessions.create(expiration: Settings.session_period.from_now)
    cookies.signed[:session] = session.id
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
