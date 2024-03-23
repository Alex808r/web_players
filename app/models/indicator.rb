# frozen_string_literal: true

class Indicator < ApplicationRecord
  has_many :performances, dependent: :destroy
  validates :description, presence: true
end
