# frozen_string_literal: true

module Services
  module Products
    class UpdateProductService
      def perform(product:, user:, params:)
        validate_product_ownership(product.user_id, user.id)

        product.update!(**params)

        product
      end

      private

      def validate_product_ownership(product_user_id, current_user_id)
        raise ::Errors::Http::NotFoundError if product_user_id != current_user_id
      end
    end
  end
end
