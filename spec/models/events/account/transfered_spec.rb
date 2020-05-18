# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Account::Transfered, type: :model do
  describe '#create' do
    it 'transfer funds from a account to another' do
      source_account = create(:account, balance: 10_000)
      destination_account = create(:account, balance: 10_000)
      described_class.create!(account: source_account, destination_account: destination_account, amount: 9000)

      expect(source_account.balance).to eq(1000)
      expect(destination_account.balance).to eq(19_000)
    end
  end
end
