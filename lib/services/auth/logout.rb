# frozen_string_literal: true

module Services
  module Auth
    class Logout
      def initialize(jwt_handler: JsonWebTokenHandler.new)
        @jwt_handler = jwt_handler
      end

      def perform(user:)
        user.update!(session_token_id: SecureRandom.hex)
      end

      private

      attr_reader :jwt_handler
    end
  end
end
