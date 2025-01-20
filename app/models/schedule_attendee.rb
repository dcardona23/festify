class ScheduleAttendee < ApplicationRecord
  belongs_to :schedule
  belongs_to :attendee
end