# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wallet do
  describe 'validate deposit amount' do
    subject { described_class.new(deposit:, user: create(:user)) }

    context 'with valid deposit amount' do
      let(:deposit) { 5 }

      it 'should return true' do
        expect(subject.valid?).to be_truthy
      end
    end

    context 'with invalid deposit amount' do
      let(:deposit) { 10_000 }

      it 'model return false' do
        expect(subject.valid?).to be_falsy
      end
    end
  end
end
