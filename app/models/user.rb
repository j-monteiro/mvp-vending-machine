# frozen_string_literal: true

class User < ApplicationRecord
  USER_ROLES = %w[buyer seller]

  encrypts :password, deterministic: true

  before_create :set_session_token_id

  validates_inclusion_of :role, in: USER_ROLES

  private

  def set_session_token_id
    self.session_token_id = SecureRandom.hex
  end
end
