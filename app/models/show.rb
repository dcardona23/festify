class Show < ApplicationRecord
  has_many :schedule_shows
  has_many :schedules, through: :schedule_shows
  has_many :attendees, through: :schedules

  validates :artist_name, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true 
end