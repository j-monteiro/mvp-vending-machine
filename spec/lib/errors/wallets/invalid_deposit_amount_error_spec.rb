# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Errors::Wallets::InvalidDepositAmountError do
  it_behaves_like 'a error code' do
    let(:code) { 400 }
  end

  it_behaves_like 'a error error_message' do
    let(:message) { 'Invalid deposit amount' }
  end

  it_behaves_like 'a error reason' do
    let(:reason) { 'invalid-deposit-amount' }
  end
end
