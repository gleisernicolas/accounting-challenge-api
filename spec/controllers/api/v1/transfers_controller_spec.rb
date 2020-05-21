# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TransfersController, type: :controller do
  before do
    request.headers['Authorization'] = Base64.encode64('ios_app:ios_token')
    request.headers['Content-Type'] = 'application/json'
  end

  describe 'POST /api/v1/transfer' do
    context 'with valid attributes' do
      context 'when source account have funds' do
        it 'perform the transfer' do
          source_account = create(:account, balance: 10_000)
          destination_account = create(:account, balance: 0)

          expect do
            post :create,
                 params: {
                   source_number: source_account.number,
                   destination_number: destination_account.number,
                   amount: 6_000
                 }
          end.to change(Events::Account::Transfered, :count).by(1)

          expect(response.status).to be(201)
          expect(JSON.parse(response.body)['message']).to eq('Successful transfer!')

          expect(source_account.reload.balance).to be(4_000)
          expect(destination_account.reload.balance).to be(6_000)
        end
      end

      context 'when source account does not have funds' do
        it 'does not perform the transfer' do
          source_account = create(:account, balance: 0)
          destination_account = create(:account, balance: 0)

          expect do
            post :create,
                 params: {
                   source_number: source_account.number,
                   destination_number: destination_account.number,
                   amount: 6_000
                 }
          end.not_to change(Events::Account::Transfered, :count)

          expect(response.status).to be(422)

          expect(source_account.reload.balance).to be(0)
          expect(destination_account.reload.balance).to be(0)
        end
      end
    end

    context 'when source account does not exists do' do
      it 'does nothing and return error message "Source Account does not exists!"' do
        expect do
          post :create,
               params: {
                 source_number: 999_666,
                 destination_number: build(:account).number,
                 amount: 6_000
               }
        end.not_to change(Events::Account::Transfered, :count)

        expect(response.status).to be(422)
        expect(JSON.parse(response.body)['message']).to eq('Source Account does not exists!')
      end
    end

    context 'when destination account does not exists do' do
      it 'does nothing and return error message "Destination Account does not exists!"' do
        expect do
          post :create,
               params: {
                 source_number: create(:account).number,
                 destination_number: 9_996_666_999,
                 amount: 6_000
               }
        end.not_to change(Events::Account::Transfered, :count)

        expect(response.status).to be(422)
        expect(JSON.parse(response.body)['message']).to eq('Destination Account does not exists!')
      end
    end
  end
end
