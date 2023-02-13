# frozen_string_literal: true

module V1
  module Products
    class UpdateOrganizer
      def initialize(
        get_products_service: Services::Products::GetProductsService.new,
        update_product_service: Services::Products::UpdateProductService.new
      )
        @get_products_service = get_products_service
        @update_product_service = update_product_service
      end

      def perform(params:, current_user:)
        product = get_products_service.perform(product_ids: [params.delete(:product_id)]).first

        unless product.nil?
          product = update_product_service.perform(
            product:,
            user: current_user,
            params:
          )
        end

        { message: 'product updated successfully', product: }
      end

      private

      attr_reader :get_products_service,
                  :update_product_service
    end
  end
end
