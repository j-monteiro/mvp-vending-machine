# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Users::DeleteOrganizer do
  subject do
    described_class.new(delete_service:)
  end

  let(:delete_service) { double(:delete_service, perform: 'the-service-response') }

  describe '#perform' do
    let(:perform) { subject.perform(params:) }
    let(:params) { { user_id: Faker::Number.number } }

    it 'delegates proper parameters to service' do
      expect(delete_service).to receive(:perform).once.with(**params)

      perform
    end

    it 'returns the service response' do
      expect(perform).to eq('the-service-response')
    end
  end
end
