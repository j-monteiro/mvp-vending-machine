# frozen_string_literal: true

module Services
  module Products
    class BuyProductService
      def initialize(get_products_service: Services::Products::GetProductsService.new)
        @get_products_service = get_products_service
      end

      def perform(wallet:, product_id:, amount:)
        product = get_products_service.perform(product_ids: [product_id]).first

        total_cost = (amount || 1) * product.cost

        raise Errors::Wallets::NotEnoughFundsError if total_cost > wallet.deposit

        wallet.deposit -= total_cost
        wallet.save!

        {
          change: calculate_change(wallet.deposit),
          product:,
          total_spent: total_cost
        }
      end

      private

      def calculate_change(change)
        [100, 50, 20, 10, 5].map do |coin|
          count = (change / coin).floor
          change -= count * coin
          [coin, count]
        end
      end

      attr_reader :get_products_service
    end
  end
end
