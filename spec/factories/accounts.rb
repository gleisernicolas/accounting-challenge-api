# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { Faker::Name.name }
    balance { Faker::Number.number(digits: 7) }
    token { SecureRandom.hex }
    number { Faker::Number.number(digits: 6) }
  end
end
