class ErrorSerializer
  include JSONAPI::Serializer

  def self.format_schedule_error
    { errors: [{ detail: "Schedule not found" }] }
  end

  def self.format_attendee_error
    { errors: [{ detail: "Attendee not found" }] }
  end

  def self.format_show_error
    { errors: [{ detail: "Show not found in schedule" }] }
  end
end