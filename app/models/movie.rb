class Movie < ApplicationRecord
  validates :title, presence: true
  validates :vote_average, presence: true, numericality: { greater_than_or_equal_to: 0 }
end