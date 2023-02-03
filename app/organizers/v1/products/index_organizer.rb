# frozen_string_literal: true

module V1
  module Products
    class IndexOrganizer
      def initialize(
        get_products_service: Services::Products::GetProductsService.new
      )
        @get_products_service = get_products_service
      end

      def perform(params:)
        params = params.to_unsafe_hash.symbolize_keys
        params[:page] = params[:page].to_i if params[:page].present?
        params[:per_page] = params[:per_page].to_i if params[:per_page].present?

        products = get_products_service.perform(**params)

        { products: }
      end

      private

      attr_reader :get_products_service
    end
  end
end
