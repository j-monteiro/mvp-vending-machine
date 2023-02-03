# frozen_string_literal: true

module JwtAuthentication
  extend ActiveSupport::Concern
  include BaseAuthentication

  private

  def authentication_service
    Services::Auth::AuthenticateJwt
  end

  def authorization_service
    Services::Auth::AuthorizeUser
  end
end
