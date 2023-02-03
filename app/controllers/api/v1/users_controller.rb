# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      def signup
        permitted = params.permit(:username, :password, :role)

        render json: ::V1::Users::SignupOrganizer.new.perform(params: permitted)
      end

      def delete
        permitted = params.permit(:user_id)

        render json: ::V1::Users::DeleteOrganizer.new.perform(params: permitted)
      end
    end
  end
end
