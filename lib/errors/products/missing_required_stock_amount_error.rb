module Errors
  module Products
    class MissingRequiredStockAmountError < Base
      def code
        400
      end

      private

      def error_message
        'Missing required product amount in stock'
      end

      def reason
        'missing-required-stock-amount'
      end
    end
  end
end
