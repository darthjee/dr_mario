# frozen_string_literal: true

require 'spec_helper'

describe MeasurementsController do
  let(:user_id) { 10 }
  let(:expected_json) do
    Measurement::Decorator.new(expected_object).to_json
  end

  describe 'GET new' do
    render_views

    context 'when requesting html and ajax is true' do
      before do
        get :new, params: { user_id: user_id, format: :html, ajax: true }
      end

      it { expect(response).to be_successful }

      it { expect(response).to render_template('measurements/new') }
    end

    context 'when requesting html and ajax is false' do
      before do
        get :new, params: { user_id: user_id }
      end

      it do
        expect(response).to redirect_to("#/users/#{user_id}/measurements/new")
      end
    end
  end

  describe 'GET index' do
    render_views

    before { create_list(:measurement, 1) }

    context 'when requesting json' do
      let(:expected_object) { Measurement.all }

      before do
        get :index, params: { user_id: user_id, format: :json }
      end

      it { expect(response).to be_successful }

      it 'returns measurements serialized' do
        expect(response.body).to eq(expected_json)
      end
    end

    context 'when requesting html and ajax is true' do
      before do
        get :index, params: { user_id: user_id, format: :html, ajax: true }
      end

      it { expect(response).to be_successful }

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

      let(:expected_object) { measurement }

      before do
        get :show, params: parameters
      end

      it { expect(response).to be_successful }

      it 'returns measurements serialized' do
        expect(response.body).to eq(expected_json)
      end
    end

    context 'when requesting html and ajax is true' do
      let(:parameters) do
        { id: :id, user_id: user_id, format: :html, ajax: true }
      end

      before { get :show, params: parameters }

      it { expect(response).to be_successful }

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
      let(:measurement) { Measurement.last }
      let(:parameters) do
        { user_id: user_id, format: :json, measurement: payload }
      end
      let(:payload) do
        {
          glicemy: 100,
          date: '2020-01-15',
          time: '10:44:55'
        }
      end

      let(:expected_object) { measurement }

      it do
        post :create, params: parameters

        expect(response).to be_successful
      end

      it do
        expect { post :create, params: parameters }
          .to change(Measurement, :count)
          .by(1)
      end

      it 'returns created measurement' do
        post :create, params: parameters

        expect(response.body).to eq(expected_json)
      end

      context 'when glicemy is nil' do
        let(:measurement) { Measurement.new(payload) }
        let(:payload) do
          {
            glicemy: nil,
            date: '2020-01-15',
            time: '10:44:55'
          }
        end

        it do
          post :create, params: parameters

          expect(response).not_to be_successful
        end

        it do
          expect { post :create, params: parameters }
            .not_to change(Measurement, :count)
        end

        it 'returns measurement with errors' do
          post :create, params: parameters

          expect(response.body).to eq(expected_json)
        end
      end

      context 'when date and time are nil' do
        let(:measurement) { Measurement.new(payload) }
        let(:payload) do
          {
            glicemy: 120,
            date: nil,
            time: nil
          }
        end

        it do
          post :create, params: parameters
          expect(response).not_to be_successful
        end

        it do
          expect { post :create, params: parameters }
            .not_to change(Measurement, :count)
        end

        it 'returns measurement with errors' do
          post :create, params: parameters

          expect(response.body).to eq(expected_json)
        end
      end
    end
  end
end
