# frozen_string_literal: true

module Services
  module Products
    class UpdateProductService
      def perform(product:, params:)
        product.update!(**params)

        product
      end
    end
  end
end
