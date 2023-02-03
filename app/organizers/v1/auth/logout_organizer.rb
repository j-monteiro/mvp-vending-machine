# frozen_string_literal: true

module V1
  module Auth
    class LogoutOrganizer
      def initialize(logout_service: Services::Auth::Logout.new)
        @logout_service = logout_service
      end

      def perform(cookies:, user:)
        cookies.delete(:user_token)

        logout_service.perform(user:)

        { message: 'user logged out successfully' }
      end

      private

      attr_reader :logout_service
    end
  end
end
