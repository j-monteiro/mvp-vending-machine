# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Users::Signup do
  describe '#perform' do
    let(:perform) { subject.perform(username:, password:) }
    let(:username) { Faker::Internet.email }
    let(:password) { Faker::Internet.password }
    let(:role) { 'buyer' }

    it 'delegates proper parameters to ORM' do
      expect(User).to receive(:create!).once.with(username:, password:, role:)

      perform
    end

    context 'with invalid role' do
      let(:role) { 'invalid' }

      it 'raises error' do
        expect { perform }.to raise_error(Errors::Users::InvalidRoleError)
      end
    end
  end
end
