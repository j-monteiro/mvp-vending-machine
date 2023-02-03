module Services
  module Wallets
    class GetUserWalletService
      def perform(user:)
        Wallet.find_by(user_id: user.id)
      end
    end
  end
end
