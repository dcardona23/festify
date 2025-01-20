class Schedule < ApplicationRecord
  has_many :schedule_attendees
  has_many :schedule_shows
  has_many :attendees, through: :schedule_attendees
  has_many :shows, through: :schedule_shows
end