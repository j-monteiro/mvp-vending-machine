module Errors
  module Users
    class InvalidRoleError < Base
      def code
        400
      end

      private

      def error_message
        'Invalid role'
      end

      def reason
        'invalid-role'
      end
    end
  end
end
