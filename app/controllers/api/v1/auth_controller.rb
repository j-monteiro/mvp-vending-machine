# frozen_string_literal: true

module Api
  module V1
    class AuthController < BaseController
      def login
        permitted = params.permit(:username, :password, :role)

        render json: ::V1::Auth::LoginOrganizer.new.perform(cookies:, params:)
      end

      def logout
        user = authenticate!

        render json: ::V1::Auth::LogoutOrganizer.new.perform(cookies:, user:)
      end
    end
  end
end
