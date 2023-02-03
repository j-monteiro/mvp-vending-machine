# frozen_string_literal: true

module Services
  module Products
    class DeleteProductService
      def perform(product_id:)
        Product.delete(product_id)
      end
    end
  end
end
