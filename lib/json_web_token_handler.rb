# frozen_string_literal: true

class JsonWebTokenHandler
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def encode(payload:, secret_key: SECRET_KEY, algorithm: 'HS256', headers: {})
    payload[:exp] ||= 8.hours.from_now.to_i

    JWT.encode(payload, secret_key, algorithm, headers)
  end

  def decode(token:, secret_key: SECRET_KEY, algorithm: 'HS256')
    verify = secret_key ? true : false

    decoded_token = JWT.decode(token, secret_key, verify, { algorithm: })[0]

    HashWithIndifferentAccess.new(decoded_token)
  rescue JWT::ExpiredSignature
    raise Errors::Auth::ExpiredSessionError
  rescue JWT::ImmatureSignature
    raise Errors::Auth::ImmatureSessionError
  rescue JWT::DecodeError
    raise Errors::Auth::UnauthorizedError
  end
end
