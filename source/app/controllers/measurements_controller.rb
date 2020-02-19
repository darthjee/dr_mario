# frozen_string_literal: true

class MeasurementsController < ApplicationController
  include OnePageApplication
  include LoggedUser

  protect_from_forgery except: [:create]

  resource_for :measurement

  before_action :check_user, only: :create

  private

  def measurements
    @measurements ||= user.measurements
  end

  def user
    User.find(params.require(:user_id))
  end

  def check_user
    raise "bla" unless user == logged_user
  end
end
