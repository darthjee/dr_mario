# frozen_string_literal: true

module LoggedUser
  SESSION_KEY = :session

  class Processor
    def initialize(controller)
      @controller = controller
    end

    def login(user)
      @logged_user = user

      cookies[SESSION_KEY] = new_session.id
    end

    def logged_user
      @logged_user ||= session&.user
    end

    private

    attr_reader :controller

    def new_session
      @session = logged_user.sessions.create(
        expiration: Settings.session_period.from_now
      )
    end

    def session
      @session ||= Session.active.find_by(id: session_id)
    end

    def session_id
      cookies[SESSION_KEY]
    rescue NoMethodError
      nil
    end

    def cookies
      @cookies ||= controller.send(:cookies).signed
    end

    def params
      @params ||= controller.send(:params)
    end
  end
end
