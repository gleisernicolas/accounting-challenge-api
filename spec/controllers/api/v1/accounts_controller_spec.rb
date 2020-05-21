# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AccountsController, type: :controller do
  before do
    request.headers['Authorization'] = Base64.encode64('ios_app:ios_token')
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
          expect(JSON.parse(response.body)['number'].nil?).to be(false)
          expect(JSON.parse(response.body)['token'].nil?).to be(false)
        end
      end

      context 'with a existing account' do
        it 'return the account number and token with the message "Account number already in use"' do
          account = create(:account)

          post :create,
               params: {
                 number: account.number
               }

          expect(response.status).to be(200)
          expect(JSON.parse(response.body)['message']).to eq('Account number already in use')
          expect(JSON.parse(response.body)['number']).to eq(account.number)
          expect(JSON.parse(response.body)['token']).to eq(account.token)
        end
      end
    end
  end

  describe 'GET /api/v1/accounts/balance' do
    context 'with a existing account' do
      it 'return the balance' do
        account = create(:account, balance: 1000)

        get :balance, params: { number: account.number }

        expect(response.status).to be(200)
        expect(JSON.parse(response.body)['balance']).to eq(account.balance)
      end
    end

    context 'without a existing account' do
      it 'return the error "Couldn\'t find Account"' do
        get :balance, params: { number: 999 }

        expect(response.status).to be(404)
        expect(JSON.parse(response.body)['message']).to eq("Couldn't find Account")
      end
    end
  end
end
