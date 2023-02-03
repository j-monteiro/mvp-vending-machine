# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include ActionController::Cookies
      include ErrorHandler
      include JwtAuthentication
    end
  end
end
