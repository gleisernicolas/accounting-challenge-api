# frozen_string_literal: true

module Events
  module Account
    class Created < Events::Account::BaseEvent
      data_attributes :name, :number, :balance, :token

      def apply(account)
        account.name = name
        account.number = number || generate_number
        account.balance = balance
        account.token = SecureRandom.hex

        data[:token] = account.token
        data[:number] = account.number

        account
      end

      private

      def generate_number
        number = rand(6**6)

        if ::Account.find_by_number(number).nil?
          number
        else
          generate_number
        end
      end
    end
  end
end
