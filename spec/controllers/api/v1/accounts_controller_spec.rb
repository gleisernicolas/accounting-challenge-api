require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  #let(:user) { create(:user) }

  before do
    request.headers['Content-Type'] = 'application/json'
  end

  describe 'POST /api/v1/accounts' do
    context 'with valid attributes' do
      context 'and new account' do
        it 'create a account' do
          name = Faker::Name.name
          balance = Faker::Number.number(digits: 8)

          expect {
            post :create,
                  params: {
                    name: name,
                    balance: balance
                  }
          }.to change(Account, :count).by(1)

          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)['name']).to eq(name)
          expect(JSON.parse(response.body)['balance']).to eq(balance)
          expect(JSON.parse(response.body)['account_number']).not_to be_nil
          expect(JSON.parse(response.body)['token']).not_to be_nil
        end
      end
      
      context 'with a existing account' do
        it 'return the account number and token' do
          account = create(:account)

          post :create,
                  params: {
                    account_number: account.account_number
                  }
          
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)['account_number']).to eq(account.account_number)
          expect(JSON.parse(response.body)['token']).to eq(account.token)
        end
      end
    end
  end 
end