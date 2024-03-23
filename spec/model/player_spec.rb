# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:team_first) { create(:team) }
  let(:team_second) { create(:team) }
  let(:player_one) { create(:player, team: team_first) }
  let(:player_two) { create(:player, team: team_second) }
  let(:match) { Match.create(team_first_id: team_first.id, team_second_id: team_second.id) }
  let(:indicator) { create(:indicator) }
  let(:performance_first) { Performance.create(player: player_one, indicator:, match:) }
  let(:performance_second) { Performance.create(player: player_one, indicator:, match:) }
  let(:performance_third) { Performance.create(player: player_two, indicator:, match:) }

  it 'factory should be valid' do
    expect(player_one).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:team) }
    it { is_expected.to have_many(:performances).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'database' do
    it { is_expected.to have_db_index(:team_id) }
    it { is_expected.to have_db_column(:team_id).with_options(null: false) }
    it { is_expected.to have_db_column(:team_id).of_type(:integer) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end

  describe '#mark_performance' do
    it 'creates a performance for the player' do
      player_one.mark_performance(match, indicator)
      expect(player_one.performances.count).to eq(1)
    end
  end

  describe '#performed_performance_in_previous_matches?' do
    before { performance_first }

    it 'returns true if player performed the indicator in previous matches' do
      expect(player_one.performed_performance_in_previous_matches?(indicator.description)).to be(true)
    end

    it 'returns false if player did not perform the indicator in previous matches' do
      expect(player_one.performed_performance_in_previous_matches?('Different Description')).to be(false)
    end
  end

  describe '#top_players_by_performance' do
    before do
      performance_first
      performance_second
      performance_third
    end

    context 'when top players by performance without team' do
      let(:top_players) { described_class.top_players_by_performance(indicator) }

      it 'returns an array of top players' do
        expect(top_players).not_to be_nil
        expect(top_players.length).to eq(2) # Assuming we have 2 players in the test data
      end

      it 'puts player one at the top' do
        expect(top_players[0]).to eq(player_one)
      end

      it 'does not put player two at the top' do
        expect(top_players[0]).not_to eq(player_two)
      end

      it 'player one has 2 performances' do
        expect(top_players[0].performances.count).to eq(2)
      end
    end

    context 'when top players by performance with current team' do
      let(:top_players) { described_class.top_players_by_performance(indicator, team_second) }

      it 'returns an array of top players' do
        expect(top_players).not_to be_nil
        expect(top_players.length).to eq(1)
      end

      it 'puts player two at the top' do
        expect(top_players[0]).to eq(player_two)
      end

      it 'does not put player one at the top' do
        expect(top_players[0]).not_to eq(player_one)
      end

      it 'player one has 1 performances' do
        expect(top_players[0].performances.count).to eq(1)
      end
    end
  end
end
