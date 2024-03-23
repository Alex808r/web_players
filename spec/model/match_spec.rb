# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Match, type: :model do
  let(:match) { create(:match) }

  it 'factory should be valid' do
    expect(match).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:team_first) }
    it { is_expected.to belong_to(:team_second) }
  end

  describe 'database' do
    it { is_expected.to have_db_index(:team_first_id) }
    it { is_expected.to have_db_index(:team_second_id) }
    it { is_expected.to have_db_column(:team_first_id).with_options(null: false) }
    it { is_expected.to have_db_column(:team_second_id).with_options(null: false) }
    it { is_expected.to have_db_column(:team_first_id).of_type(:integer) }
    it { is_expected.to have_db_column(:team_second_id).of_type(:integer) }
  end

  describe 'match have correctly team' do
    let(:team_first) { create(:team) }
    let(:team_second) { create(:team) }
    let(:match) { described_class.create(team_first_id: team_first.id, team_second_id: team_second.id) }

    it { expect(match.team_first).to eq team_first }
    it { expect(match.team_second).to eq team_second }
  end
end
