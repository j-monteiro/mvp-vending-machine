# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Auth::AuthorizeUser do
  describe '#perform' do
    let(:perform) { subject.perform(user:, authorized_roles:) }

    let(:user) { create(:user) }
    let(:authorized_roles) { ['buyer'] }

    it 'does not raise error' do
      expect { perform }.not_to raise_error
    end

    context 'with invalid role' do
      let(:authorized_roles) { ['seller'] }

      it 'raises error' do
        expect { perform }.to raise_error(Errors::Auth::UnauthorizedError)
      end
    end
  end
end
