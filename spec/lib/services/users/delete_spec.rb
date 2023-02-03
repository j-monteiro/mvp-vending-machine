# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Users::Delete do
  describe '#perform' do
    let(:perform) { subject.perform(user_id:) }
    let(:user_id) { Faker::Number.number }

    it 'delegates proper parameters to ORM' do
      expect(User).to receive(:delete).once.with(user_id)

      perform
    end
  end
end
