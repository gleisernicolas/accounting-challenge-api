# frozen_string_literal: true

module Events
  module Account
    class Transfered < Events::Account::BaseEvent
      validate :transfer_cannot_be_greater_than_source_account_balance
      validates_numericality_of :amount, greater_than_or_equal_to: 1
      validates_presence_of :destination_account, :amount

      data_attributes :source_account, :destination_account, :amount

      def apply(_account = nil)

        source_account.balance -= amount
        destination_account.balance += amount
        destination_account.save

        source_account
      end

      private

      def transfer_cannot_be_greater_than_source_account_balance
        if amount.to_i > source_account.balance
          errors.add(:amount, 'Transfer amount cannot be greater than source account balance')
        end
      end
    end
  end
end

