# frozen_string_literal: true

class Performance < ApplicationRecord
  belongs_to :match
  belongs_to :player
  belongs_to :indicator
end
