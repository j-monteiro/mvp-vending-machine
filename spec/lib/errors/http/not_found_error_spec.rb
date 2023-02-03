# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Errors::Http::NotFoundError do
  it_behaves_like 'a error code' do
    let(:code) { 404 }
  end

  it_behaves_like 'a error error_message' do
    let(:message) { 'Not found' }
  end

  it_behaves_like 'a error reason' do
    let(:reason) { 'not-found' }
  end
end
