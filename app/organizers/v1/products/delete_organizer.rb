# frozen_string_literal: true

module V1
  module Products
    class DeleteOrganizer
      def initialize(
        delete_product_service: Services::Products::DeleteProductService.new
      )
        @delete_product_service = delete_product_service
      end

      def perform(params:)
        delete_product_service.perform(product_id: params[:product_id])

        { message: 'product delete successfully', product_id: params[:product_id] }
      end

      private

      attr_reader :delete_product_service
    end
  end
end
