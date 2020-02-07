# frozen_string_literal: true

class MeasurementsController < ApplicationController
  include OnePageApplication

  protect_from_forgery except: [:create]

  resource_for :measurement

  private

  def measurements
    @measurements ||= user.measurements
  end

  def user
    User.find(params.require(:user_id))
  end
end
