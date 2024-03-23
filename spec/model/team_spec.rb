# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { create(:team) }
  let(:player) { create(:player) }
  let!(:players) { create_list(:player, 3, team:) }

  it 'factory should be valid' do
    expect(team).to be_valid
  end

  it 'team has players' do
    expect(players.size).to eq team.players.count
  end
end
