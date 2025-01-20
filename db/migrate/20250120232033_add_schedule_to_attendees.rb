class AddScheduleToAttendees < ActiveRecord::Migration[7.1]
  def change
    add_reference :attendees, :schedule, foreign_key: true
  end
end
