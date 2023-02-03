# frozen_string_literal: true

module Errors
  module Wallets
    class NotEnoughFundsError < Base
      def code
        400
      end

      private

      def error_message
        'Not enough funds to make the purchase'
      end

      def reason
        'not-enough-funds'
      end
    end
  end
end
