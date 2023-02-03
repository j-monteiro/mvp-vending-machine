# frozen_string_literal: true

module Services
  module Products
    class CreateProductService
      def perform(reference:, params:)
        product = Product.find_by(reference:)

        if product.present?
          product.update!({ **params, amount_available: product.amount_available + 1 })
          return product.id
        end

        Product.create!(reference:, **params).id
      end
    end
  end
end
