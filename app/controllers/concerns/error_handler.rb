module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ::Errors::Base, with: :custom_error
    # rescue_from ::ActiveRecord::, with: :custom_error
  end

  private

  def custom_error(error)
    render json: error.to_h, status: error.code
  end
end
