# frozen_string_literal: true

require 'spec_helper'

fdescribe LoginController do
  let(:user)     { create(:user, password: password) }
  let(:login)    { user.login }
  let(:password) { 'password' }

  let(:parameters) do
    {
      login: {
        login: login,
        password: password
      }
    }
  end

  describe 'POST create' do
    context 'when login is correct' do
      xit 'creates a session' do
        expect do
          post :create, params: parameters
        end
      end

      context 'after request' do
        let(:expected_json) do
          User::Decorator.new(user).to_json
        end

        before do
          post :create, params: parameters
        end

        it do
          expect(response).to be_successful
        end

        it 'returns user serialized' do
          expect(response.body).to eq(expected_json)
        end
      end
    end
  end
end

