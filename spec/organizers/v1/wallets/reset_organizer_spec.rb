# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Wallets::ResetOrganizer do
  subject do
    described_class.new(reset_wallet_service:, get_user_wallet_service:)
  end

  let(:reset_wallet_service) { double(:reset_wallet_service, perform: 'the-reset_wallet_service-response') }
  let(:get_user_wallet_service) { double(:get_user_wallet_service, perform: wallet) }
  let(:wallet) { double(:wallet) }

  describe '#perform' do
    let(:perform) { subject.perform(params:) }
    let(:params) { { user:, amount: } }
    let(:user) { double(:user) }
    let(:amount) { Faker::Number.number }

    it 'delegates proper parameters to get_user_wallet_service' do
      expect(get_user_wallet_service).to receive(:perform).once.with(user: params[:user])

      perform
    end

    it 'delegates proper parameters to reset_wallet_service' do
      expect(reset_wallet_service).to receive(:perform).once.with(wallet:)

      perform
    end

    it 'returns the service response' do
      expect(perform).to eq({ message: 'wallet reseted successfully' })
    end
  end
end
