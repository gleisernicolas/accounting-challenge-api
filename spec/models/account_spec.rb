# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create(:account) }

  context 'with validations' do
    it { is_expected.to validate_uniqueness_of(:number) }
    it { is_expected.to validate_uniqueness_of(:token) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_presence_of(:balance) }
  end
end
