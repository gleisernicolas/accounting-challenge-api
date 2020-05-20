# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApplicationController
      def create
        number = account_params[:number]
        existing_account = Account.find_by_number(number)

        if existing_account
          json_response({ number: existing_account.number,
                          token: existing_account.token }, :ok)
        else
          created_event = Events::Account::Created.create!(account_params)
          account = created_event.account

          json_response(account, :created)
        end
      end

      def balance
        account = Account.find_by_number!(params[:number])

        json_response( { balance: account.balance }, :ok )
      end

      private

      def account_params
        params.require(:account).permit(:name,
                                        :number,
                                        :balance)
      end
    end
  end
end
