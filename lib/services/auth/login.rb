# frozen_string_literal: true

module Services
  module Auth
    class Login
      def initialize(jwt_handler: JsonWebTokenHandler.new)
        @jwt_handler = jwt_handler
      end

      def perform(username:, password:, role:)
        user = User.find_by(username:, password:, role:)

        raise Errors::Http::NotFoundError if user.nil?

        generate_jwt(user.id, user.session_token_id)
      end

      private

      def generate_jwt(user_id, session_token_id)
        jwt_handler.encode(
          payload: {
            iss: 'mvp',
            iat: Time.zone.now.to_i,
            exp: 5.minutes.from_now.to_i,
            sub: user_id,
            id: session_token_id
          }
        )
      end

      attr_reader :jwt_handler
    end
  end
end
