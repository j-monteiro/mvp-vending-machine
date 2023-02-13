# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Products::BuyProductService do
  let(:get_products_service) { double(:get_products_service, perform: [product]) }
  let(:product) { create(:product, cost: product_cost) }
  let(:product_cost) { 10.5 }

  subject { described_class.new(get_products_service:) }

  describe '#perform' do
    let(:perform) { subject.perform(wallet:, product_id:, amount: requested_amount) }

    let(:wallet) { create(:wallet, deposit: 320) }
    let(:product_id) { product.id }
    let(:requested_amount) { 1 }

    it 'delegates proper parameters to get_products_service' do
      expect(get_products_service)
        .to receive(:perform)
        .once
        .with(product_ids: [product.id])

      perform
    end

    it 'calculates proper change' do
      expect(perform[:change]).to match([[100, 3], [50, 0], [20, 0], [10, 0], [5, 1]])
    end

    it 'returns the aquired product' do
      expect(perform[:product]).to eq(product)
    end

    it 'returns total spent value' do
      expect(perform[:total_spent]).to eq(product.cost)
    end

    context 'when amount is more than 1' do
      let(:product) { create(:product, amount_available: 2) }
      let(:requested_amount) { 2 }

      it 'returns total spent value' do
        expect(perform[:total_spent]).to eq(product.cost * requested_amount)
      end
    end

    context 'when product stock amount is not enough' do
      let(:product) { create(:product, amount_available: 0) }

      it 'raises error' do
        expect { perform }.to raise_error(::Errors::Products::MissingRequiredStockAmountError)
      end
    end
  end
end
