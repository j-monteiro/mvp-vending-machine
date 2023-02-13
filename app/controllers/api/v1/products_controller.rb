# frozen_string_literal: true

module Api
  module V1
    class ProductsController < BaseController
      def index
        authenticate_and_authorize!(authorized_roles: %w[buyer seller])

        permitted = params.permit(:ids, :page, :per_page, :order, :order_by)

        render json: ::V1::Products::IndexOrganizer.new.perform(params: permitted)
      end

      def create
        authenticate_and_authorize!(authorized_roles: ['seller'])

        permitted = params.permit(:reference, :cost, :product_name, :amount)

        render json: ::V1::Products::CreateOrganizer.new.perform(params: permitted)
      end

      def update
        authenticate_and_authorize!(authorized_roles: ['seller'])

        permitted = params.permit(:product_id, :cost, :name, :amount)

        render json: ::V1::Products::UpdateOrganizer.new.perform(params: permitted, current_user: user)
      end

      def delete
        authenticate_and_authorize!(authorized_roles: ['seller'])

        permitted = params.permit(:product_id)

        render json: ::V1::Products::DeleteOrganizer.new.perform(params: permitted)
      end

      def buy
        user = authenticate_and_authorize!(authorized_roles: ['buyer'])

        permitted = params.permit(:product_id, :amount)

        render json: ::V1::Products::BuyOrganizer.new.perform(params: permitted.merge(user:))
      end
    end
  end
end
