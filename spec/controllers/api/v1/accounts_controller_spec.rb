# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  # let(:user) { create(:user) }

  before do
    request.headers['Content-Type'] = 'application/json'
  end

  describe 'POST /api/v1/accounts' do
    context 'with valid attributes' do
      context 'with a new new account' do
        it 'create a account' do
          name = Faker::Name.name
          balance = Faker::Number.number(digits: 8)

          expect do
            post :create,
                 params: {
                   name: name,
                   balance: balance
                 }
          end.to change(Account, :count).by(1)

          expect(response.status).to be(201)
          expect(JSON.parse(response.body)['name']).to eq(name)
          expect(JSON.parse(response.body)['balance']).to eq(balance)
          expect(JSON.parse(response.body)['account_number'].nil?).to be(false)
          expect(JSON.parse(response.body)['token'].nil?).to be(false)
        end
      end

      context 'with a existing account' do
        it 'return the account number and token' do
          account = create(:account)

          post :create,
               params: {
                 account_number: account.account_number
               }

          expect(response.status).to be(200)
          expect(JSON.parse(response.body)['account_number']).to eq(account.account_number)
          expect(JSON.parse(response.body)['token']).to eq(account.token)
        end
      end
    end
  end
end
