# frozen_string_literal: true

module V1
  module Products
    class CreateOrganizer
      def initialize(
        create_product_service: Services::Products::CreateProductService.new
      )
        @create_product_service = create_product_service
      end

      def perform(params:)
        product_id = create_product_service.perform(reference: params.delete(:reference), params:)

        { message: 'product created successfully', product_id: }
      end

      private

      attr_reader :create_product_service
    end
  end
end
