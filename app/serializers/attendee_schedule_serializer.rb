class AttendeeScheduleSerializer
  include JSONAPI::Serializer

  def self.format_attendee_schedule(attendee, attendee_schedule, schedule_shows, schedule_attendees)
    {
      data: [
        {
          attendee_id: attendee.id,
          type: 'attendee schedule',
          attributes: {
            schedule: {
              schedule_name: attendee_schedule.name,
              schedule_description: attendee_schedule.description
            }
            schedule_shows: {
              
            }
          }
        }
      ]
    }
  end
end