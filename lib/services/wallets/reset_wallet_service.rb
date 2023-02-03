# frozen_string_literal: true

module Services
  module Wallets
    class ResetWalletService
      def perform(wallet:)
        wallet.update!(deposit: 0)
      end
    end
  end
end
