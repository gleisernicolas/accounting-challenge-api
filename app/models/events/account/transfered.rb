# frozen_string_literal: true

module Events
  module Account
    class Transfered < Events::Account::BaseEvent
      data_attributes :source_account, :destination_account, :amount

      def apply(account)
        ::Account.transaction do
          account.balance -= amount
          destination_account.balance += amount
          destination_account.save
        end

        data[:source_account] = account
        account
      end
    end
  end
end
