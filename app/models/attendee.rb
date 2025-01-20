class Attendee < ApplicationRecord
  has_many :schedule_attendees
  has_many :schedules, through: :schedule_attendees
  has_many :shows, through: :schedules
end