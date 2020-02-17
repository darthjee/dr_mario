describe Session do
  describe 'scopes' do
    describe '.valid' do
      let!(:session) do
        create(:session, expiration: expiration)
      end

      context 'when session has expiration in the future' do
        let(:expiration) { 2.days.from_now }

        it do
          expect(described_class.valid).to include(session)
        end
      end

      context 'when session has expiration in the past' do
        let(:expiration) { 2.days.ago }

        it do
          expect(described_class.valid).not_to include(session)
        end
      end

      context 'when session has no expiration' do
        let(:expiration) { nil }

        it do
          expect(described_class.valid).to include(session)
        end
      end
    end
  end
end
