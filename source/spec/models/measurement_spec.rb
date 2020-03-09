# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Measurement, type: :model do
  subject(:measurement) { build(:measurement) }

  describe 'validations' do
    it do
      expect(measurement).to validate_presence_of(:glicemy)
    end

    it do
      expect(measurement).to validate_presence_of(:date)
    end

    it do
      expect(measurement).to validate_presence_of(:time)
    end
  end

  describe "fields" do
    context "with high glicemy" do
      subject(:measurement) { build(:measurement, glicemy: 999) }

      it "accepts high glicemy" do
        expect { measurement.save! }.not_to raise_error
      end
    end
  end
end
