# frozen_string_literal: true

class MeasurementsController < ApplicationController
  include OnePageApplication
  include LoggedUser

  rescue_from DrMario::Exception::Unauthorized, with: :forbidden

  protect_from_forgery except: [:create]

  resource_for :measurement

  before_action :check_user, only: :create

  private

  def measurements
    @measurements ||= user.measurements.order(date: :desc, time: :desc)
  end

  def user
    User.find(params.require(:user_id))
  end

  def check_user
    return if user == logged_user

    raise DrMario::Exception::Unauthorized
  end
end
