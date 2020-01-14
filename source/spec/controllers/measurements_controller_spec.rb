# frozen_string_literal: true

require 'spec_helper'

describe MeasurementsController do
  let(:user_id) { 10 }

  describe 'GET index' do
    render_views

    before { create_list(:measurement, 1) }

    context 'when requesting json' do
      let(:expected_json) { Measurement.all.to_json }

      before do
        get :index, params: { user_id: user_id, format: :json }
      end

      it 'returns measurements serialized' do
        expect(response.body).to eq(expected_json)
      end
    end

    context 'when requesting html and ajax is true' do
      before do
        get :index, params: { user_id: user_id, format: :html, ajax: true }
      end

      it { expect(response).to render_template('measurements/index') }
    end

    context 'when requesting html and ajax is false' do
      before do
        get :index, params: { user_id: user_id }
      end

      it { expect(response).to redirect_to("#/users/#{user_id}/measurements") }
    end
  end

  describe 'GET show' do
    render_views

    let(:measurement)    { create(:measurement) }
    let(:measurement_id) { measurement.id }

    context 'when requesting json' do
      let(:parameters) do
        { id: measurement_id, user_id: user_id, format: :json }
      end

      let(:expected_json) { measurement.to_json }

      before do
        get :show, params: parameters
      end

      it 'returns measurements serialized' do
        expect(response.body).to eq(expected_json)
      end
    end

    context 'when requesting html and ajax is true' do
      let(:parameters) do
        { id: :id, user_id: user_id, format: :html, ajax: true }
      end

      before { get :show, params: parameters }

      it { expect(response).to render_template('measurements/show') }
    end

    context 'when requesting html and ajax is false' do
      before do
        get :show, params: { user_id: user_id, id: :id }
      end

      it do
        expect(response).to redirect_to("#/users/#{user_id}/measurements/id")
      end
    end
  end

  describe 'POST create' do
    context 'when requesting json format' do
      let(:payload)     { { name: 'My Measurement' } }
      let(:measurement) { Measurement.last }
      let(:parameters) do
        { user_id: user_id, format: :json, measurement: payload }
      end

      let(:expected_json) { measurement.to_json }

      it do
        expect { post :create, params: parameters }
          .to change(Measurement, :count)
          .by(1)
      end

      it 'returns created measurement' do
        post :create, params: parameters

        expect(response.body).to eq(expected_json)
      end

      context 'when name is nil' do
        let(:payload) { { name: nil } }

        it do
          expect { post :create, params: parameters }
            .to change(Measurement, :count)
            .by(1)
        end

        it 'returns created measurement' do
          post :create, params: parameters

          expect(response.body).to eq(expected_json)
        end
      end

      context 'when payload contains code' do
        let(:payload) { { code: my_code } }
        let(:my_code) { 'my code' }

        it do
          expect { post :create, params: parameters }
            .to change(Measurement, :count)
            .by(1)
        end

        it 'does not accept the code' do
          post :create, params: parameters

          expect(response.body).not_to match(my_code)
        end
      end
    end
  end
end
