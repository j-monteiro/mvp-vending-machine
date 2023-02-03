# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Wallets::ResetWalletService do
  describe '#perform' do
    let(:perform) { subject.perform(wallet:) }
    let(:wallet) { double(:wallet, update!: '', deposit: 5) }

    it 'delegates proper parameters to ORM' do
      expect(wallet).to receive(:update!).once.with(deposit: 0)

      perform
    end
  end
end
