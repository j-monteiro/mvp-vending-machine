# frozen_string_literal: true

module Errors
  module Auth
    class ExpiredSessionError < Base
      def code
        401
      end

      private

      def error_message
        'Current session has expired'
      end

      def reason
        'expired-session'
      end
    end
  end
end
