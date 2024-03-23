# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Performance, type: :model do
  let(:performance) { create(:performance) }

  it 'factory should be valid' do
    expect(performance).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:match) }
    it { is_expected.to belong_to(:player) }
    it { is_expected.to belong_to(:indicator) }
  end

  describe 'database' do
    it { is_expected.to have_db_index(:match_id) }
    it { is_expected.to have_db_index(:player_id) }
    it { is_expected.to have_db_index(:indicator_id) }
    it { is_expected.to have_db_column(:match_id).with_options(null: false) }
    it { is_expected.to have_db_column(:player_id).with_options(null: false) }
    it { is_expected.to have_db_column(:indicator_id).with_options(null: false) }
  end
end
