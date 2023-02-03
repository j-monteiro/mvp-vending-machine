# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonWebTokenHandler do
  before { travel_to Time.zone.now }
  after { travel_back }

  let(:exp) { 5.minutes.from_now.to_i }
  let(:nbf) { 5.minutes.ago.to_i }
  let(:secret_key) { 'the-secret-key' }
  let(:algorithm) { 'HS256' }
  let(:headers) { { kid: 'the-kid' } }
  let(:payload) do
    {
      nbf:,
      exp:,
      iss: :mvp
    }
  end

  describe '#encode' do
    let(:perform) { subject.encode(payload:, secret_key:, algorithm:, headers:) }

    it 'delegates proper parameters to JWT' do
      expect(JWT)
        .to receive(:encode)
        .with(payload, secret_key, algorithm, headers)

      perform
    end

    it 'returns a valid jwt token' do
      expect { JWT.decode(perform, nil, false) }.not_to raise_error
    end

    it 'generates token with expected headers' do
      decoded = JWT.decode(perform, nil, false)

      expect(decoded[1]).to include(headers.stringify_keys)
    end
  end

  describe '#decode' do
    let(:perform) { subject.decode(token:) }

    let(:token) { JWT.encode(payload, secret_key, algorithm) }
    let(:decode_secret_key) { secret_key }
    let(:perform) do
      subject.decode(token:, secret_key: decode_secret_key, algorithm:)
    end

    it 'delegates proper parameters to JWT decode' do
      expect(JWT)
        .to receive(:decode)
        .with(token, decode_secret_key, true, { algorithm: })
        .and_call_original

      perform
    end

    it 'returns proper token decoded in hash' do
      expect(perform).to eq({ 'exp' => exp, 'iss' => 'mvp', 'nbf' => nbf })
    end

    context 'when expiration has passed' do
      let(:exp) { 1.minute.ago.to_i }

      it 'raises session expired error' do
        expect { perform }.to raise_error(Errors::Auth::ExpiredSessionError)
      end
    end

    context 'when is yet to be started' do
      let(:nbf) { 1.minute.from_now.to_i }

      it 'raises session yet to be started error' do
        expect { perform }.to raise_error(Errors::Auth::ImmatureSessionError)
      end
    end

    context 'when token is invalid' do
      let(:token) { 'invalid-token' }

      it 'raises unauthorized error' do
        expect { perform }.to raise_error(Errors::Auth::UnauthorizedError)
      end
    end

    context 'when secret key is nil' do
      let(:decode_secret_key) { nil }

      it 'delegates proper parameters to JWT decode' do
        expect(JWT)
          .to receive(:decode)
          .with(token, nil, false, { algorithm: })
          .and_call_original

        perform
      end
    end
  end
end
