# frozen_string_literal: true

module V1
  module Wallets
    class ResetOrganizer
      def initialize(
        reset_wallet_service: Services::Wallets::ResetWalletService.new,
        get_user_wallet_service: Services::Wallets::GetUserWalletService.new
      )
        @reset_wallet_service = reset_wallet_service
        @get_user_wallet_service = get_user_wallet_service
      end

      def perform(params:)
        wallet = get_user_wallet_service.perform(user: params[:user])

        reset_wallet_service.perform(wallet:)

        { message: 'wallet reseted successfully' }
      end

      private

      attr_reader :reset_wallet_service,
                  :get_user_wallet_service
    end
  end
end
