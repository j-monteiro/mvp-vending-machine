# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.email }
    password { Faker::Internet.password }
    role { 'buyer' }
  end
end
