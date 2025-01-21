class Attendee < ApplicationRecord
  belongs_to :schedule

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def get_attendee_schedule
    schedule
  end

  def get_schedule_shows
    schedule.shows
  end

  def get_schedule_attendees
    schedule.attendees
  end

end