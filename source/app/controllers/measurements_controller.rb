# frozen_string_literal: true

class MeasurementsController < ApplicationController
  include OnePageApplication

  protect_from_forgery except: [:create]

  resource_for :measurement
end
