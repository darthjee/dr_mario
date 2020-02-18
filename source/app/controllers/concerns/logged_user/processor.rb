class LoggedUser::Processor
  def initialize(controller)
    @controller = controller
  end

  def user
    @user ||= user_from_login
  end

  private

  attr_reader :controller

  def user_from_login
    User.login(login_params).tap do |user|
      session = user.sessions.create(
        expiration: Settings.session_period.from_now
      )
      cookies[:session] = session.id
    end
  end

  def login_params
    params.require(:login).permit(:login, :password)
          .to_h.symbolize_keys
  end

  def cookies
    @cookies ||= controller.send(:cookies).signed
  end

  def params
    @params ||= controller.send(:params)
  end
end
