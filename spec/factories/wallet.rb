# frozen_string_literal: true

FactoryBot.define do
  factory :wallet do
    deposit { 5 }
    user { build(:user) }
  end
end
