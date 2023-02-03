# frozen_string_literal: true

module Errors
  module Wallets
    class InvalidDepositAmountError < Base
      def code
        400
      end

      private

      def error_message
        'Invalid deposit amount'
      end

      def reason
        'invalid-deposit-amount'
      end
    end
  end
end
