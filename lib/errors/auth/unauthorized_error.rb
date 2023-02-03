# frozen_string_literal: true

module Errors
  module Auth
    class UnauthorizedError < Base
      def code
        401
      end

      private

      def error_message
        'Unauthorized'
      end

      def reason
        'unauthorized'
      end
    end
  end
end
