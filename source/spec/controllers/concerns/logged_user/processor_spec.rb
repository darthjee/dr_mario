require 'spec_helper'

describe LoggedUser::Processor do
  subject(:processor) { described_class.new(controller) }

  let(:user)       { create(:user) }
  let(:controller) { instance_double(controller_class, cookies: cookies) }
  let(:cookies)    { instance_double(ActionDispatch::Cookies::CookieJar) }

  let(:signed_cookies) { {} }

  let(:controller_class) do
    Class.new(ApplicationController)
  end

  before do
    allow(cookies).to receive(:signed).and_return(signed_cookies)
  end

  describe "#login" do
    let(:session) { Session.last }

    it 'creates a session' do
      expect { processor.login(user) }
        .to change(Session, :count).by(1)
    end

    it 'sets signed cookie' do
      expect { processor.login(user) }
        .to change { signed_cookies[:session] }
        .from(nil)
    end

    context 'when login has been called' do
      let(:expected_expiration_range) do
        (Settings.session_period.from_now-1.second)..
        Settings.session_period.from_now
      end

      before do
        processor.login(user)
      end

      it 'sets signed cookie to session id' do
        expect(signed_cookies[:session]).to eq(session.id)
      end

      it 'creates session for user' do
        expect(session.user).to eq(user)
      end

      it 'creates a session with expiration date' do
        expect(session.expiration)
          .to be_in(expected_expiration_range)
      end
    end
  end

  describe '#logged_user' do
    context 'when user is not logged' do
      it { expect(processor.logged_user).to be_nil }
    end

    context 'when user is logged' do
      let(:session) do
        create(:session, expiration: expiration, user: user)
      end
      
      before do
        signed_cookies[:session] = session.id
      end

      context 'without expiration' do
        let(:expiration) { nil }

        it 'returns the user' do
          expect(processor.logged_user).to eq(user)
        end
      end

      context 'with expiration in the future' do
        let(:expiration) { 2.days.from_now }

        it 'returns the user' do
          expect(processor.logged_user).to eq(user)
        end
      end

      context 'with expiration in the past' do
        let(:expiration) { 2.days.ago }

        it 'returns the user' do
          expect(processor.logged_user).to be_nil
        end
      end
    end
  end
end
