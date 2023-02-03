# frozen_string_literal: true

module Errors
  module Auth
    class ImmatureSessionError < Base
      def code
        401
      end

      private

      def error_message
        'Session not yet started'
      end

      def reason
        'immature-session'
      end
    end
  end
end
