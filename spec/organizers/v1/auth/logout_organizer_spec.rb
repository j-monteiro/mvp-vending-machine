# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Auth::LogoutOrganizer do
  subject do
    described_class.new(logout_service:)
  end

  let(:logout_service) { double(:logout_service, perform: 'the-service-response') }

  describe '#perform' do
    let(:perform) { subject.perform(cookies:, user:) }
    let(:cookies) { { user_token: 'the-user-token' } }
    let(:user) { double(:user) }

    it 'delegates proper parameters to service' do
      expect(logout_service).to receive(:perform).once.with(user:)

      perform
    end

    it 'returns the service response' do
      expect(perform).to eq({ message: 'user logged out successfully' })
    end
  end
end
