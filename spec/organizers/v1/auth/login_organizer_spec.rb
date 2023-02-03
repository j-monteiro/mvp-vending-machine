# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Auth::LoginOrganizer do
  subject do
    described_class.new(login_service:)
  end

  let(:login_service) { double(:login_service, perform: 'the-service-response') }

  describe '#perform' do
    let(:perform) { subject.perform(params:) }
    let(:params) { { username: Faker::Internet.email, password: Faker::Internet.password, role: 'the-role' } }

    it 'delegates proper parameters to service' do
      expect(login_service).to receive(:perform).once.with(**params)

      perform
    end

    it 'returns the service response' do
      expect(perform).to eq({ token: 'the-service-response' })
    end
  end
end
