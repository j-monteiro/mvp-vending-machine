# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Products::CreateOrganizer do
  subject do
    described_class.new(create_product_service:)
  end

  let(:create_product_service) { double(:create_product_service, perform: product_id) }
  let(:product_id) { Faker::Number.number }

  describe '#perform' do
    let(:perform) { subject.perform(params:) }
    let(:params) { { reference: Faker::Internet.uuid, amount: Faker::Number.decimal(l_digits: 2), other: 'param' } }

    it 'delegates proper parameters to service' do
      expect(create_product_service).to receive(:perform).once.with(
        reference: params[:reference], params: { amount_available: params[:amount], other: 'param' }
      )

      perform
    end

    it 'returns the service response' do
      expect(perform).to eq({ message: 'product created successfully', product_id: })
    end
  end
end
