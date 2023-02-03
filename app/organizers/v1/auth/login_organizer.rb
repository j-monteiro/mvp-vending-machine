# frozen_string_literal: true

module V1
  module Auth
    class LoginOrganizer
      def initialize(login_service: Services::Auth::Login.new)
        @login_service = login_service
      end

      def perform(cookies:, params:)
        cookies.signed[:user_token] = login_service.perform(
          username: params[:username],
          password: params[:password],
          role: params[:role]
        )
      end

      private

      attr_reader :login_service
    end
  end
end
