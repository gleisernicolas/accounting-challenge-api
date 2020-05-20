# frozen_string_literal: true

module Events
  module Account
    class BaseEvent < Lib::BaseEvent
      self.table_name = 'account_events'

      belongs_to :account, class_name: '::Account', autosave: false
      attribute :data, :encrypted, random_iv: false, type: :json
      attribute :metadata, :encrypted, random_iv: false, type: :json
    end
  end
end
