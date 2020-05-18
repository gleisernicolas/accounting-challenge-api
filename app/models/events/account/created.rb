# frozen_string_literal: true

module Events
  module Account
    class Created < Events::Account::BaseEvent
      data_attributes :name, :account_number, :balance, :token

      def apply(account)
        account.name = name
        account.account_number = account_number || generate_account_number
        account.balance = balance
        account.token = SecureRandom.hex

        data[:token] = account.token
        data[:account_number] = account.account_number

        account
      end

      private

      def generate_account_number
        number = rand(6**6)

        if ::Account.find_by_account_number(number).nil?
          number
        else
          generate_account_number
        end
      end
    end
  end
end
