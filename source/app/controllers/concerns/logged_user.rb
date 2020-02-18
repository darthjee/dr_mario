# frozen_string_literal: true

module LoggedUser
  extend ActiveSupport::Concern

  included do
    rescue_from DrMario::Exception::LoginFailed, with: :not_found
  end

  private

  def save_session
    Processor.new(self).login(user)
  end
end
