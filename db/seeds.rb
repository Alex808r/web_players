# frozen_string_literal: true

# Create Teams
team_first = Team.find_or_create_by(name: 'Динамо')
team_second = Team.find_or_create_by(name: 'Спартак')

# Create 6 Players by 3 on team
# Игрок Динамо 1, 2, 3
# Игрок Спартак 1, 2, 3
def create_players(team, index)
  team.players.find_or_create_by(name: "Игрок #{team.name} #{index + 1}")
end

3.times do |index|
  create_players(team_first, index)
  create_players(team_second, index)
end

# Create Indicator
Indicator.find_or_create_by(description: 'Пробежал 10 км')
Indicator.find_or_create_by(description: 'Сделал 70% успешных передач')

# Create match
# home match for team_first
match_first = Match.create(date: Date.current, location: 'Moscow', team_first:, team_second:)
# guest match for team_first
match_second = Match.create(date: Date.current + 1.day, location: 'Moscow', team_first: team_second, team_second: team_first)
# home match 2 for team_first
match_last = Match.create(date: Date.current + 2.day, location: 'Moscow', team_first:, team_second:)

# Create performance
Performance.create(player: Player.first, match: match_first, indicator: Indicator.first)
Performance.create(player: Player.first, match: match_second, indicator: Indicator.last)

Performance.create(player: Player.last, match: match_first, indicator: Indicator.first)
Performance.create(player: Player.last, match: match_last, indicator: Indicator.last)
