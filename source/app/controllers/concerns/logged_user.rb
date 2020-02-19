# frozen_string_literal: true

module LoggedUser
  extend ActiveSupport::Concern

  included do
    rescue_from DrMario::Exception::LoginFailed, with: :not_found
  end

  private

  def save_session
    logged_user_processor.login(user)
  end

  def logged_user
    @logged_user ||= logged_user_processor.logged_user
  end

  def logged_user_processor
    @logged_user_processor ||= Processor.new(self)
  end
end
