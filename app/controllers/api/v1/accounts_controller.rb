class Api::V1::AccountsController < ApplicationController
  #beforebefore_action :set_account, only: :create


  def create
    existing_account = Account.find_by_account_number(account_params[:account_number])

    if existing_account
      response_params = { account_number: existing_account.account_number,
                          token: existing_account.token }

      json_response(response_params, :ok)
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