# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Events::Account::Transfered, type: :model do
  describe '#create' do
    let(:source_account) { create(:account, balance: 10_000) }
    let(:destination_account) { create(:account, balance: 5_000) }

    context '#validations' do
      it 'amount must be positive greater than one integer' do
        expect { described_class.create!(source_account: source_account, destination_account: destination_account, amount: -1000) }.
          to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Amount must be greater than or equal to 1')
      end
    end

    context 'when source account have funds' do
      it 'transfer funds from a account to another' do
        described_class.create!(source_account: source_account, destination_account: destination_account, amount: 9000)

        expect(source_account.balance).to eq(1000)
        expect(destination_account.balance).to eq(14_000)
      end
    end

    context 'when source account does not have funds' do
      it 'does not complete the transfer' do
        expect { described_class.create!(source_account: source_account, destination_account: destination_account, amount: 200_000) }.
          to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Amount Transfer amount cannot be greater than source account balance')

        expect(source_account.reload.balance).to eq(10_000)
        expect(destination_account.reload.balance).to eq(5_000)
      end
    end
  end
end
