# frozen_string_literal: true

module BaseAuthentication
  extend ActiveSupport::Concern

  def authenticate_and_authorize!(authorized_roles:)
    user = authenticate!
    authorize!(user:, authorized_roles:)
  end

  private

  def authenticate!
    authentication_service.new.perform(token: cookies.signed[:user_token])
  end

  def authorize!(user:, authorized_roles:)
    authorization_service.new.perform(user:, authorized_roles:)
  end

  def authentication_service
    raise 'not implemented'
  end

  def authorization_service
    raise 'not implemented'
  end
end
