# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :players, dependent: :destroy
  # Игры дома
  has_many :first_team_matches, class_name: 'Match', foreign_key: 'team_first_id', dependent: :destroy
  # Игры в гостях
  has_many :second_team_matches, class_name: 'Match', foreign_key: 'team_second_id', dependent: :destroy

  # def all_matches
  #   (first_team_matches + second_team_matches).uniq
  # end

  def matches
    Match.where('team_first_id = :team_id OR team_second_id = :team_id', team_id: id)
  end
end
