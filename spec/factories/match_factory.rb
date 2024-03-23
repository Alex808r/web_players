# frozen_string_literal: true

FactoryBot.define do
  factory :match do
    date { Date.current }
    location { 'Moscow' }
    team_first factory: %i[team]
    team_second factory: %i[team]
  end
end
