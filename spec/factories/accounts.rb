# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { 'MyString' }
    balance { '999' }
    token { 'MyText' }
  end
end
