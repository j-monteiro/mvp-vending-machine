# frozen_string_literal: true

module Services
  module Wallets
    class DepositService
      def perform(wallet:, amount:)
        raise Errors::Wallets::InvalidDepositAmountError unless valid_amount?(amount)

        wallet.update!(deposit: wallet.deposit + amount)
      end

      def valid_amount?(amount)
        amount.in?(Wallet::VALID_DEPOSIT_AMOUNT)
      end
    end
  end
end
