# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Errors::Products::MissingRequiredStockAmountError do
  it_behaves_like 'a error code' do
    let(:code) { 400 }
  end

  it_behaves_like 'a error error_message' do
    let(:message) { 'Missing required product amount in stock' }
  end

  it_behaves_like 'a error reason' do
    let(:reason) { 'missing-required-stock-amount' }
  end
end
