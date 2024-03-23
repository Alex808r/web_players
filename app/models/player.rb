# frozen_string_literal: true

class Player < ApplicationRecord
  has_many :performances, dependent: :destroy
  belongs_to :team

  validates :name, presence: true

  def mark_performance(match, indicator)
    performances.create!(match:, indicator:)
  end

  def performed_performance_in_previous_matches?(indicator_description)
    # performances.joins(:indicator)
    # .where({ indicator: { description: indicator_description } })
    # .where('match_id IN (?)', team.matches.last(5).pluck(:id)).exists?
    performances
      .joins(:indicator).where({ indicator: { description: indicator_description } })
      .exists?(match_id: team.matches.last(5).pluck(:id))
  end

  def self.top_players_by_performance(indicator = Indicator.first, team_id = nil)
    query = Player.joins(performances: :indicator).where(indicators: { id: indicator.id }).distinct

    query = query.where(team_id:) if team_id

    query.select('players.*, COUNT(performances.id) AS performances_count')
         .group('players.id')
         .order('performances_count DESC')
         .limit(5)
  end
end
