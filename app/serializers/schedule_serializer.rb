class ScheduleSerializer
  include JSONAPI::Serializer
  attributes :name, :description 

  def self.format_schedules(schedules)
    {
      data: schedules.map do |schedule|
        {
          id: schedule.id,
          type: 'schedule',
          attributes: {
            name: schedule.name,
            description: schedule.description,
            shows: (schedule.shows || []).map do |show|
              {
                id: show.id.to_s,
                artist_name: show.artist_name,
                genre: show.genre,
                location: show.location,
                start_time: show.start_time, 
                end_time: show.end_time
              }
            end
            },
            other_schedule_attendees: (schedule.attendees || []).map do |other_attendee|
              {
                attendee_id: other_attendee.id,
                attendee_name: "#{other_attendee.first_name} #{other_attendee.last_name}",
                attendee_email: other_attendee.email
              }
            end
          }
        end
      }
  end

  def self.format_schedule(schedule)
    {
      data: [
        {
          id: schedule.id,
          type: 'schedule',
          attributes: {
            name: schedule.name,
            description: schedule.description,
            shows: schedule.shows.map do |show|
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
            other_schedule_attendees: schedule.attendees.map do |other_attendee|
              {
                attendee_id: other_attendee.id,
                attendee_name: "#{other_attendee.first_name} #{other_attendee.last_name}",
                attendee_email: other_attendee.email
              }
            end
          }
        ]
      }
  end
end