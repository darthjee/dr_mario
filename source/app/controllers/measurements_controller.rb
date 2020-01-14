# frozen_string_literal: true

class MeasurementsController < ApplicationController
  include OnePageApplication

  resource_for :measurement
end

