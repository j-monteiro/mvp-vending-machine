# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Products::UpdateProductService do
  describe 'perform' do
    let(:perform) { subject.perform(product:, user:, params: new_params) }
    let(:user) { product.user }
    let(:product) { create(:product) }
    let(:new_params) do
      {
        amount_available: Faker::Number.decimal(l_digits: 2),
        cost: Faker::Number.number,
        product_name: Faker::Food.dish,
        reference: Faker::Internet.uuid
      }
    end

    it 'updates the product with the new values' do
      expect(product)
        .to receive(:update!)
        .once
        .with(**new_params)

      perform
    end

    context 'when product product does not belong to user' do
      let(:user) { create(:user) }

      it 'raises error' do
        expect { perform }.to raise_error(::Errors::Http::NotFoundError)
      end

      it 'does not update product' do
        expect(product).not_to receive(:update!)

        perform
      rescue ::Errors::Http::NotFoundError => e
      end
    end
  end
end
