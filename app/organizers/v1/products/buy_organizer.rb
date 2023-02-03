# frozen_string_literal: true

module V1
  module Products
    class BuyOrganizer
      def initialize(
        buy_product_service: Services::Products::BuyProductService.new,
        get_user_wallet_service: Services::Wallets::GetUserWalletService.new
      )
        @buy_product_service = buy_product_service
        @get_user_wallet_service = get_user_wallet_service
      end

      def perform(params:)
        wallet = get_user_wallet_service.perform(user: params[:user])
        order = buy_product_service.perform(wallet:, product_id: params[:product_id], amount: params[:amount])

        { message: 'order processed successfully!', order: }
      end

      private

      attr_reader :buy_product_service,
                  :get_user_wallet_service
    end
  end
end
