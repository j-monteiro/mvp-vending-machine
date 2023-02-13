# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    amount_available { 1 }
    cost { Faker::Number.decimal(l_digits: 2) }
    product_name { Faker::Food.dish }
    reference { Faker::Internet.uuid }
    user { build(:user, role: 'seller') }
  end
end
