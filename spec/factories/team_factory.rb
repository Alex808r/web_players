# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "Team name N: #{n}"
  end

  factory :team do
    name
  end
end
