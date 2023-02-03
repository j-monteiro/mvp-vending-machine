# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Wallets::DepositOrganizer do
  subject do
    described_class.new(deposit_service:, get_user_wallet_service:)
  end

  let(:deposit_service) { double(:deposit_service, perform: 'the-deposit_service-response') }
  let(:get_user_wallet_service) { double(:get_user_wallet_service, perform: wallet) }
  let(:wallet) { double(:wallet, deposit: Faker::Number.number) }

  describe '#perform' do
    let(:perform) { subject.perform(params:) }
    let(:params) { { user:, amount: } }
    let(:user) { double(:user) }
    let(:amount) { Faker::Number.number }

    it 'delegates proper parameters to get_user_wallet_service' do
      expect(get_user_wallet_service).to receive(:perform).once.with(user: params[:user])

      perform
    end

    it 'delegates proper parameters to deposit_service' do
      expect(deposit_service).to receive(:perform).once.with(wallet:, amount: params[:amount])

      perform
    end

    it 'returns the service response' do
      expect(perform).to eq({ current_deposit: wallet.deposit })
    end
  end
end
