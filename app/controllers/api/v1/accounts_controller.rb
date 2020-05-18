# frozen_string_literal: true

module Api
  module V1
    class AccountsController < ApplicationController
      def create
        account_number = account_params[:account_number]
        existing_account = Account.find_by_account_number(account_number)

        if existing_account
          json_response({ account_number: existing_account.account_number,
                          token: existing_account.token }, :ok)
        else
          created_event = Events::Account::Created.create!(account_params)
          account = created_event.account

          json_response(account, :created)
        end
      end

      private

      def account_params
        params.require(:account).permit(:name,
                                        :account_number,
                                        :balance)
      end
    end
  end
end
