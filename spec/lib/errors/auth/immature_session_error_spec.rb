# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Errors::Auth::ImmatureSessionError do
  it_behaves_like 'a error code' do
    let(:code) { 401 }
  end

  it_behaves_like 'a error error_message' do
    let(:message) { 'Session not yet started' }
  end

  it_behaves_like 'a error reason' do
    let(:reason) { 'immature-session' }
  end
end
