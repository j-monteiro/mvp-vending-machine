# frozen_string_literal: true

class Wallet < ApplicationRecord
  VALID_DEPOSIT_AMOUNT = [5, 10, 20, 50, 100].freeze

  belongs_to :user
end
