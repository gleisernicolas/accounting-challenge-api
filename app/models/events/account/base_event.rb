# frozen_string_literal: true

class Events::Account::BaseEvent < Lib::BaseEvent
  self.table_name = 'account_events'

  belongs_to :account, class_name: '::Account', autosave: false
end
