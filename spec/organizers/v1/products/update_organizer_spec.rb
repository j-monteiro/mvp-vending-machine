# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Products::UpdateOrganizer do
  subject do
    described_class.new(get_products_service:, update_product_service:)
  end

  let(:get_products_service) { double(:get_products_service, perform: [product]) }
  let(:update_product_service) { double(:update_product_service, perform: product) }
  let(:product) { double(:product, id: Faker::Number.number) }

  describe '#perform' do
    let(:perform) { subject.perform(params:, current_user:) }
    let(:current_user) { double(:current_user) }
    let(:params) { { product_id: product.id, other: 'param' } }

    it 'delegates proper parameters to get_products_service' do
      expect(get_products_service)
        .to receive(:perform)
        .once
        .with(product_ids: [product.id])

      perform
    end

    it 'delegates proper parameters to update_product_service' do
      expect(update_product_service).to receive(:perform).once.with(
        product:,
        user: current_user,
        params: { other: 'param' }
      )

      perform
    end

    it 'returns the service response' do
      expect(perform).to eq({ message: 'product updated successfully', product: })
    end
  end
end
