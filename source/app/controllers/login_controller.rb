# frozen_string_literal: true

class LoginController < ApplicationController
  rescue_from DrMario::Exception::LoginFailed, with: :not_found

  protect_from_forgery except: [:create]

  def create
    cookies.signed[:session] = session.id
    render json: User::Decorator.new(logged_user)
  end

  private

  def logged_user
    @logged_user ||= User.login(login_params)
  end

  def session
    @session ||= logged_user.sessions.create(
      expiration: Settings.session_period.from_now
    )
  end

  def login_params
    params.require(:login).permit(:login, :password)
      .to_h.symbolize_keys
  end
end
