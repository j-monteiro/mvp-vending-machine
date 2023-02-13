# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Errors::Products::DuplicatedError do
  it_behaves_like 'a error code' do
    let(:code) { 400 }
  end

  it_behaves_like 'a error error_message' do
    let(:message) { 'Duplicated product reference' }
  end

  it_behaves_like 'a error reason' do
    let(:reason) { 'duplicated-product-error' }
  end
end
