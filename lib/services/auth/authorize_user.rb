# frozen_string_literal: true

module Services
  module Auth
    class AuthorizeUser
      def perform(user:, authorized_roles:)
        raise Errors::Auth::UnauthorizedError unless user.role.in?(authorized_roles)

        user
      end
    end
  end
end
