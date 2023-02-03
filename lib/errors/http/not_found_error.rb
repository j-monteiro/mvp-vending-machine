module Errors
  module Http
    class NotFoundError < Base
      def code
        404
      end

      private

      def error_message
        'Not found'
      end

      def reason
        'not-found'
      end
    end
  end
end
