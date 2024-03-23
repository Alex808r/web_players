# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :team_first, class_name: 'Team'
  belongs_to :team_second, class_name: 'Team'
end
