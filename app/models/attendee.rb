class Attendee < ApplicationRecord
  has_many :schedule_attendees
  has_many :schedules, through: :schedule_attendees
  has_many :shows, through: :schedules

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end