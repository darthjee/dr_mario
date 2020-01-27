# frozen_string_literal: true

require 'spec_helper'

describe Measurement::Decorator do
  subject(:decorator) { described_class.new(object) }

  let(:attributes)    { %w[id glicemy time date] }

  describe '#to_json' do
    context 'when object is one entity' do
      let(:object) { create(:measurement) }
      let(:expected_json) do
        object.as_json.slice(*attributes).to_json
      end

      it 'returns expected json' do
        expect(decorator.to_json).to eq(expected_json)
      end
    end

    context 'when object is invalid' do
      let(:object) { build(:measurement, glicemy: nil) }
      let(:expected_errors) { { glicemy: ["can't be blank"] } }
      let(:expected_json) do
        object
          .as_json
          .slice(*attributes)
          .merge(errors: expected_errors).to_json
      end

      it 'returns expected json with errors' do
        expect(decorator.to_json).to eq(expected_json)
      end
    end

    context 'when object is a collection' do
      let(:object) { Measurement.all }
      let(:expected_json) do
        object.map do |measurement|
          measurement.as_json.slice(*attributes)
        end.to_json
      end

      before { create_list(:measurement, 3) }

      it 'returns expected json' do
        expect(decorator.to_json).to eq(expected_json)
      end
    end

    context 'when object is a collection with invalid objects' do
      let(:expected_errors) { { glicemy: ["can't be blank"] } }
      let(:object) do
        Measurement.all.tap do |measurements|
          measurements.each do |measurement|
            measurement.update(glicemy: nil)
          end
        end
      end

      let(:expected_json) do
        object.map do |measurement|
          measurement
            .as_json
            .slice(*attributes)
            .merge(errors: expected_errors)
        end.to_json
      end

      before { create_list(:measurement, 2) }

      it 'returns expected json' do
        expect(decorator.to_json).to eq(expected_json)
      end
    end
  end
end
