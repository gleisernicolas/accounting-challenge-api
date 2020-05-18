# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Account::Created, type: :model do
  describe '#create' do
    it 'create a new account with the valid data' do
      expect do
        described_class.create!(name: 'Foo', account_number: 999, balance: 0)
      end.to change(Account, :count).by(1)
    end

    it 'create a new account_number only if one is not provided' do
      account = described_class.create!(name: 'Foo', balance: 0)

      expect(account.account_number.nil?).to be(false)

      new_account = described_class.create!(name: 'Foo', account_number: 996_699, balance: 0)
      expect(new_account.account_number).to be(996_699)
    end

    it 'create a token' do
      account = described_class.create!(name: 'Foo', balance: 0)

      expect(account.token.nil?).to be(false)
    end
  end
end
