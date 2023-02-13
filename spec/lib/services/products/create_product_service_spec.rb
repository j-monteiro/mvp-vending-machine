# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Products::CreateProductService do
  describe '#perform' do
    let(:perform) { subject.perform(reference:, params:) }
    let(:reference) { Faker::Internet.uuid }
    let(:params) do
      {
        amount_available: Faker::Number.within(range: 1..100),
        cost: Faker::Number.decimal(l_digits: 2),
        product_name: Faker::Food.dish,
        reference:,
        user_id: user.id
      }
    end
    let(:user) { create(:user, role: 'seller') }

    it 'returns the product id' do
      expect(perform).to eq(Product.last.id)
    end

    it 'creates a new product record' do
      expect { perform }.to change(Product, :count).by(1)
    end

    context 'when a product with the same reference already exists?' do
      before { create(:product, reference:) }

      it 'raises error' do
        expect { perform }.to raise_error(::Errors::Products::DuplicatedError)
      end
    end
  end
end
