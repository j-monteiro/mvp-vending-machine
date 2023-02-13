# frozen_string_literal: true

module Services
  module Products
    class BuyProductService
      def initialize(get_products_service: Services::Products::GetProductsService.new)
        @get_products_service = get_products_service
      end

      def perform(wallet:, product_id:, amount:)
        product = get_products_service.perform(product_ids: [product_id]).first

        validate_product_availability(product.amount_available, amount)

        total_cost = calculate_total_cost(amount, product.cost)

        validate_enough_funds(total_cost, wallet.deposit)

        persist_purchase(wallet, product, total_cost, amount)

        {
          change: calculate_change(wallet.deposit),
          product:,
          total_spent: total_cost
        }
      end

      private

      def persist_purchase(wallet, product, total_cost, amount)
        ActiveRecord::Base.transaction do
          wallet.update!(deposit: wallet.deposit - total_cost)
          product.update!(amount_available: product.amount_available - amount)
        end
      end

      def calculate_total_cost(amount, product_cost)
        (amount || 1) * product_cost
      end

      def calculate_change(change)
        [100, 50, 20, 10, 5].map do |coin|
          count = (change / coin).floor
          change -= count * coin
          [coin, count]
        end
      end

      def validate_enough_funds(total_cost, current_deposit)
        raise Errors::Wallets::NotEnoughFundsError if total_cost > current_deposit
      end

      def validate_product_availability(amount_available, requested_amount)
        raise ::Errors::Products::MissingRequiredStockAmountError if amount_available < requested_amount
      end

      attr_reader :get_products_service
    end
  end
end
