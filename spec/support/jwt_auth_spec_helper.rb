# frozen_string_literal: true

module JwtAuthSpecHelper
  def self.included(base)
    base.class_eval do
      let(:jwt) do
        JsonWebTokenHandler.new.encode(
          payload: json_web_token_payload
        )
      end

      let(:json_web_token_payload) do
        {
          exp: 5.minutes.from_now.to_i,
          iat: Time.zone.now.to_i
        }
      end
    end
  end
end
