# frozen_string_literal: true

module V1
  module Users
    class SignupOrganizer
      def initialize(signup_service: Services::Users::Signup.new)
        @signup_service = signup_service
      end

      def perform(params:)
        signup_service.perform(
          username: params[:username],
          password: params[:password],
          role: params[:role]
        )

        { message: 'user created successfully' }
      end

      private

      attr_reader :signup_service
    end
  end
end
