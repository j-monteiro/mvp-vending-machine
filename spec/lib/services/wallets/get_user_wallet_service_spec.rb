# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Wallets::GetUserWalletService do
  describe '#perform' do
    let(:perform) { subject.perform(user:) }
    let(:user) { double(:user, id: Faker::Number.number) }

    it 'delegates proper parameters to ORM' do
      expect(Wallet).to receive(:find_by).once.with(user_id: user.id)

      perform
    end
  end
end
