# frozen_string_literal: true

module Services
  module Users
    class Signup
      def perform(username:, password:, role:)
        raise Errors::Users::InvalidRoleError unless valid_role?(role)

        user = nil

        ActiveRecord::Base.transaction do
          user = User.create!(username:, password:, role:)
          Wallet.create!(user:)
        end

        user
      end

      private

      def valid_role?(role)
        (%w[buyer seller] & [role.downcase]).any?
      end
    end
  end
end
