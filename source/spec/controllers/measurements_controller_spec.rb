# frozen_string_literal: true

require 'spec_helper'

describe MeasurementsController do
  let(:user)    { create(:user) }
  let(:user_id) { user.id }
  let(:expected_json) do
    Measurement::Decorator.new(expected_object).to_json
  end

  describe 'GET new' do
    render_views

    context 'when requesting html and ajax is true', :cached do
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

    context 'when requesting json', :not_cached do
      let(:expected_object) { user.measurements.new }

      before do
        get :new, params: { user_id: user_id, format: :json }
      end

      it { expect(response).to be_successful }

      it 'returns measurements serialized' do
        expect(response.body).to eq(expected_json)
      end
    end
  end

  describe 'GET index' do
    render_views

    before { create_list(:measurement, 1, user: user) }

    context 'when requesting json', :not_cached do
      let(:expected_object) { Measurement.all }

      before do
        get :index, params: { user_id: user_id, format: :json }
      end

      it { expect(response).to be_successful }

      it 'returns measurements serialized' do
        expect(response.body).to eq(expected_json)
      end
    end

    context 'when requesting html and ajax is true', :cached do
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

  describe 'POST create' do
    let(:session) { create(:session, user: user) }

    before do
      cookies.signed[:session] = session.id
    end

    context 'when reque ting json format and user is not logged' do
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

      before do
        cookies.delete(:session)
      end

      it do
        expect { post :create, params: parameters }
          .not_to change(Measurement, :count)
      end

      it do
        post :create, params: parameters

        expect(response).not_to be_successful
      end

      it do
        post :create, params: parameters

        expect(response.status).to eq(403)
      end
    end

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
        let(:measurement) do
          Measurement.new(payload.merge(user_id: user_id))
        end

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
        let(:measurement) do
          Measurement.new(payload.merge(user_id: user_id))
        end
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
