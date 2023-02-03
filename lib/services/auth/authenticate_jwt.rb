# frozen_string_literal: true

module Services
  module Auth
    class AuthenticateJwt
      def initialize(jwt_handler: JsonWebTokenHandler.new)
        @jwt_handler = jwt_handler
      end

      def perform(token:)
        decoded_token = jwt_handler.decode(token:)

        user = User.find_by(id: decoded_token['sub'], session_token_id: decoded_token['id'])

        raise Errors::Auth::UnauthorizedError if user.nil?

        user
      end

      private

      attr_reader :jwt_handler
    end
  end
end
