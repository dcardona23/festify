class Schedule < ApplicationRecord
  has_many :attendees
  has_many :schedule_shows
  has_many :shows, through: :schedule_shows
end