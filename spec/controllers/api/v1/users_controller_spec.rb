# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  describe '#signup' do
    let(:perform) { post '/api/v1/users', params: request_params }
    let(:request_params) do
      {
        'username' => username,
        'password' => password,
        'role' => role
      }.as_json
    end

    let(:username) { Faker::Internet.email }
    let(:password) { Faker::Internet.email }

    context 'with buyer role' do
      let(:role) { 'buyer' }

      it 'returns status code 200' do
        expect(perform.status).to eq(200)
      end

      it 'return expected response' do
        expect(perform.parsed_json).to eq({})
      end

      it 'saves a new user in the databse' do
        expect { perform }.to change(User, :count).by(1)
      end

      it 'saves the user with the expected attributes' do
        perform

        expect(User.last.attributes).to include(**request_params.stringify_keys)
      end
    end

    context 'with seller role' do
      let(:role) { 'seller' }

      it 'returns status code 200' do
        expect(perform.status).to eq(200)
      end

      it 'return expected response' do
        expect(perform.parsed_json).to eq({})
      end

      it 'saves a new user in the databse' do
        expect { perform }.to change(User, :count).by(1)
      end

      it 'saves the user with the expected attributes' do
        perform

        expect(User.last.attributes).to include(**request_params.stringify_keys)
      end
    end
  end

  describe '#delete' do
  end
end
