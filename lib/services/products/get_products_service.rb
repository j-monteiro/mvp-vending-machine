# frozen_string_literal: true

module Services
  module Products
    class GetProductsService
      def perform(order: :asc, page: 1, per_page: 50, order_by: nil, product_ids: [])
        query = Product.all

        query = query.where(id: product_ids) if product_ids.any?

        query = query.order(order_by => order) if order_by.present?

        query = query.limit(per_page)
        query = query.offset((page - 1) * per_page) if per_page.present?
        query
      end
    end
  end
end
