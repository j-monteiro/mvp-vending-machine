module Errors
  module Products
    class DuplicatedError < Base
      def code
        400
      end

      private

      def error_message
        'Duplicated product reference'
      end

      def reason
        'duplicated-product-error'
      end
    end
  end
end
