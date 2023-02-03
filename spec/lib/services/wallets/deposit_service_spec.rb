# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Wallets::DepositService do
  describe '#perform' do
    let(:perform) { subject.perform(wallet:, amount:) }
    let(:amount) { 5 }
    let(:wallet) { double(:wallet, update!: '', deposit: 5) }

    it 'delegates proper parameters to ORM' do
      expect(wallet).to receive(:update!).once.with(deposit: 10)

      perform
    end

    context 'with invalid deposit amount' do
      let(:amount) { 10_000 }

      it 'raises error' do
        expect { perform }.to raise_error(Errors::Wallets::InvalidDepositAmountError)
      end
    end
  end
end
