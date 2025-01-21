class AttendeeScheduleSerializer
  include JSONAPI::Serializer

  def self.format_attendee_schedule(attendee, attendee_schedule, schedule_shows, schedule_attendees)
    {
      data: [
        {
          attendee_id: attendee.id,
          type: 'attendee schedule',
          attributes: {
            attendee_name: "#{attendee.first_name} #{attendee.last_name}",
            attendee_email: attendee.email,
            schedule: {
              schedule_name: attendee_schedule.name,
              schedule_description: attendee_schedule.description,
              shows: schedule_shows.map do |show|
                {
                  id: show.id.to_s,
                  artist_name: show.artist_name,
                  genre: show.genre,
                  location: show.location,
                  start_time: show.start_time, 
                  end_time: show.end_time
                }
              end,
            },
            other_schedule_attendees: schedule_attendees.map do |other_attendee|
              {
                attendee_id: other_attendee.id,
                attendee_name: "#{other_attendee.first_name} #{other_attendee.last_name}",
                attendee_email: other_attendee.email
              }
            end
          }
        }
      ]
    }
  end
end