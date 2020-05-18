# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create(:account) }
  
  context 'validations' do
    it { should validate_uniqueness_of(:account_number) }
    it { should validate_uniqueness_of(:token) }
    it { should validate_presence_of(:account_number) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:token) }
    it { should validate_presence_of(:balance) }
  end
end
