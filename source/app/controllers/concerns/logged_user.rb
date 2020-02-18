# frozen_string_literal: true

module LoggedUser
  extend ActiveSupport::Concern

  included do
    rescue_from DrMario::Exception::LoginFailed, with: :not_found
  end

  private

  def logged_user
    @logged_user ||= user_from_login
  end

  def user_from_login
    User.login(login_params).tap do |user|
      session = user.sessions.create(
        expiration: Settings.session_period.from_now
      )
      cookies.signed[:session] = session.id
    end
  end

  def login_params
    params.require(:login).permit(:login, :password)
          .to_h.symbolize_keys
  end
end
