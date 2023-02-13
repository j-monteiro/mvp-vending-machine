# frozen_string_literal: true

module Services
  module Products
    class DeleteProductService
      def perform(product_id:, user_id:)
        validate_product_ownership(product_id, user_id)

        Product.delete(product_id)
      end

      private

      def validate_product_ownership(product_user_id, current_user_id)
        raise ::Errors::Http::NotFoundError if product_user_id != current_user_id
      end
    end
  end
end
