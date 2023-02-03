# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Errors::Auth::ExpiredSessionError do
  it_behaves_like 'a error code' do
    let(:code) { 401 }
  end

  it_behaves_like 'a error error_message' do
    let(:message) { 'Current session has expired' }
  end

  it_behaves_like 'a error reason' do
    let(:reason) { 'expired-session' }
  end
end
