# frozen_string_literal: true

module Api
  module V1
    class WalletController < BaseController
      before_action { @user = authenticate_and_authorize!(authorized_roles: ['buyer']) }

      def deposit
        permitted = params.permit(:amount)

        render json: ::V1::Wallets::DepositOrganizer.new.perform(params: permitted.merge(user:))
      end

      def reset
        render json: ::V1::Wallets::ResetOrganizer.new.perform(params: { user: })
      end

      private

      attr_reader :user
    end
  end
end
