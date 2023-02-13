# frozen_string_literal: true

module Services
  module Products
    class CreateProductService
      def perform(reference:, params:)
        raise ::Errors::Products::DuplicatedError if Product.exists?(reference:)

        Product.create!(reference:, **params).id
      end
    end
  end
end
