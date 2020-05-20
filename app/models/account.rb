# frozen_string_literal: true

class Account < ApplicationRecord
  attribute :name, :encrypted, random_iv: false, type: :string
  attribute :number, :encrypted, random_iv: false, type: :integer
  attribute :token, :encrypted, random_iv: false, type: :string

  validates_presence_of :name, :balance, :number, :token
  validates_uniqueness_of :number, case_sensitive: true
  validates_uniqueness_of :token, case_sensitive: true
end
