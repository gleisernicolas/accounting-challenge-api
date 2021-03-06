# frozen_string_literal: true

module Api
  module V1
    class TransfersController < ApplicationController
      def create
        source_number = transfer_params[:source_number]
        destination_number = transfer_params[:destination_number]

        source_account = Account.find_by_number(source_number)
        destination_account = Account.find_by_number(destination_number)

        if source_account.nil?
          message = { message: 'Source Account does not exists!' }

          json_response(message, :unprocessable_entity)
        elsif destination_account.nil?
          message = { message: 'Destination Account does not exists!' }

          json_response(message, :unprocessable_entity)
        else
          amount = transfer_params[:amount]
          Events::Account::Transfered.create!(source_account: source_account, destination_account: destination_account, amount: amount)

          json_response({ message: 'Successful transfer!' }, :created)
        end
      end

      private

      def transfer_params
        params.permit(:source_number, :destination_number, :amount)
      end
    end
  end
end
