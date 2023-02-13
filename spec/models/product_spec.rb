# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

RSpec.describe Product do
  it { is_expected.to belong_to(:user) }
end
