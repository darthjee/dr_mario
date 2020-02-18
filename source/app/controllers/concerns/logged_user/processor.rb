# frozen_string_literal: true

class LoggedUser::Processor
  def initialize(controller)
    @controller = controller
  end

  def login(user)
    @user = user
    cookies[:session] = session.id
  end

  private

  attr_reader :controller, :user

  def session
    @session ||= user.sessions.create(
      expiration: Settings.session_period.from_now
    )
  end

  def cookies
    @cookies ||= controller.send(:cookies).signed
  end

  def params
    @params ||= controller.send(:params)
  end
end
