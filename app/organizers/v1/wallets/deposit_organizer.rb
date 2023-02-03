# frozen_string_literal: true

module V1
  module Wallets
    class DepositOrganizer
      def initialize(
        deposit_service: Services::Wallets::DepositService.new,
        get_user_wallet_service: Services::Wallets::GetUserWalletService.new
      )
        @deposit_service = deposit_service
        @get_user_wallet_service = get_user_wallet_service
      end

      def perform(params:)
        wallet = get_user_wallet_service.perform(user: params[:user])

        deposit_service.perform(
          wallet:,
          amount: params[:amount]
        )

        { current_deposit: wallet.deposit }
      end

      private

      attr_reader :deposit_service,
                  :get_user_wallet_service
    end
  end
end
