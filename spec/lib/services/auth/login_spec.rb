# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Auth::Login do
  include JwtAuthSpecHelper

  before { travel_to Time.zone.now }
  after { travel_back }

  subject { described_class.new(jwt_handler:) }
  let(:jwt_handler) { double(:jwt_handler, decode: decoded_token_hash) }
  let(:decoded_token_hash) { { 'sub' => 1 } }

  describe '#perform' do
    let(:perform) { subject.perform(username:, password:, role:) }
    let(:username) { Faker::Internet.email }
    let(:password) { Faker::Internet.password }
    let(:role) { 'buyer' }
    let!(:user) { create(:user, username:, password:) }

    it 'delegates proper parameters to jwt_handler' do
      expect(jwt_handler).to receive(:encode).once.with(
        payload: {
          iss: 'mvp',
          iat: Time.zone.now.to_i,
          exp: 5.minutes.from_now.to_i,
          sub: user.id,
          id: user.session_token_id
        }
      )

      perform
    end

    context 'with invalid credentials' do
      let!(:user) { create(:user, username: 'different-username', password: 'different-password') }

      it 'raises error' do
        expect { perform }.to raise_error(Errors::Http::NotFoundError)
      end
    end
  end
end
