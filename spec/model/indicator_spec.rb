# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Indicator, type: :model do
  let(:indicator) { create(:indicator) }

  it 'factory should be valid' do
    expect(indicator).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_many(:performances).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :description }
  end

  describe 'database' do
    it { is_expected.to have_db_column(:description).of_type(:string) }
  end
end
