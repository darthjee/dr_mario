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
    User.last
  end
end
