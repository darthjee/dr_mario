# frozen_string_literal: true

module LoggedUser
  extend ActiveSupport::Concern

  included do
    rescue_from DrMario::Exception::LoginFailed, with: :not_found
  end

  private

  def logged_user
    @logged_user ||= Processor.new(self).user
  end
end
