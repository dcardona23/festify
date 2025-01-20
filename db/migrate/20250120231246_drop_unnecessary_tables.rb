class DropUnnecessaryTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :schedule_attendees
    drop_table :schedule_shows
  end
end
