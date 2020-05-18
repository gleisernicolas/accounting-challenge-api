# frozen_string_literal: true

class Account < ApplicationRecord
  validates_presence_of :name, :balance, :account_number, :token
  validates_uniqueness_of :account_number, :token
end
