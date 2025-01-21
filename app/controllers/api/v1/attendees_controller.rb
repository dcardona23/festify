class Api::V1::AttendeesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_not_found

  def index
    attendees = Attendee.all
    render json: AttendeeSerializer.new(Attendee.all)
  end
  
  def show
    attendee = Attendee.find_by(id: params[:attendee_id])
    attendee_schedule = attendee.get_attendee_schedule
    schedule_shows = attendee.get_schedule_shows
    schedule_attendees = attendee.get_schedule_attendees
    render json: AttendeeScheduleSerializer.format_attendee_schedule(attendee, attendee_schedule, schedule_shows, schedule_attendees)
  end

  private

  def record_not_found(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)), status: :not_found
  end
end