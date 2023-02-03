# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe User do
  subject { described_class.new(username:, password:, role:) }
  let(:username) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }
  let(:role) { 'buyer' }

  describe '#set_session_token_id' do
    it 'sets the value of session_token_id with SecureRandom#hex' do
      allow(SecureRandom).to receive(:hex).and_return('the-value')

      subject.save!

      expect(subject.session_token_id).to eq('the-value')
    end
  end

  describe 'validations' do
    it 'accepts valid role' do
      expect(subject.valid?).to be_truthy
    end

    context 'with invalid role value' do
      let(:role) { :invalid }

      it 'model validation fails' do
        expect(subject.valid?).to be_falsy
      end
    end
  end
end
