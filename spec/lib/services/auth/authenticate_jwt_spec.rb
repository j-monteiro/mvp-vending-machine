# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Auth::AuthenticateJwt do
  include JwtAuthSpecHelper

  let(:jwt_handler) { double(:jwt_handler, decode: { 'sub' => 1, 'id' => user.session_token_id }) }

  subject { described_class.new(jwt_handler:) }

  describe '#perform' do
    let(:perform) { subject.perform(token: jwt) }
    let(:json_web_token_payload) do
      {
        exp: 5.minutes.from_now.to_i,
        iat: Time.zone.now.to_i,
        sub: user.id.to_s,
        id: user.session_token_id
      }
    end
    let(:user) { create(:user) }

    it 'delegates proper parameters to jwt_handler' do
      expect(jwt_handler)
        .to receive(:decode)
        .once
        .with(token: jwt)

      perform
    end

    context 'when sub does not match the user id' do
      let(:json_web_token_payload) do
        {
          exp: 5.minutes.from_now.to_i,
          iat: Time.zone.now.to_i,
          sub: '1',
          id: user.session_token_id
        }
      end

      it 'raises error' do
        expect { perform }.to raise_error(Errors::Auth::UnauthorizedError)
      end
    end

    context 'when id does not match the user session_token_id' do
      let(:json_web_token_payload) do
        {
          exp: 5.minutes.from_now.to_i,
          iat: Time.zone.now.to_i,
          sub: user.id.to_s,
          id: 'invalid'
        }
      end

      it 'raises error' do
        expect { perform }.to raise_error(Errors::Auth::UnauthorizedError)
      end
    end
  end
end
