class CreateScheduleAttendees < ActiveRecord::Migration[7.1]
  def change
    create_table :schedule_attendees do |t|
      t.references :schedule, null: false, foreign_key: true
      t.references :attendee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
