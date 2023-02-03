# frozen_string_literal: true

module V1
  module Users
    class DeleteOrganizer
      def initialize(delete_service: Services::Users::Delete.new)
        @delete_service = delete_service
      end

      def perform(params:)
        delete_service.perform(user_id: params[:user_id])

        { message: 'user deleted successfully' }
      end

      private

      attr_reader :delete_service
    end
  end
end
