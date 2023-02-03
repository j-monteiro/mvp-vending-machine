# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Users::SignupOrganizer do
  subject do
    described_class.new(signup_service:)
  end

  let(:signup_service) { double(:signup_service, perform: 'the-service-response') }

  describe '#perform' do
    let(:perform) { subject.perform(params:) }
    let(:params) { { username:, password:, role: } }
    let(:username) { Faker::Internet.email }
    let(:password) { Faker::Internet.password }
    let(:role) { 'the-role' }

    it 'delegates proper parameters to service' do
      expect(signup_service).to receive(:perform).once.with(**params)

      perform
    end

    it 'returns the service response' do
      expect(perform).to eq('the-service-response')
    end
  end
end
