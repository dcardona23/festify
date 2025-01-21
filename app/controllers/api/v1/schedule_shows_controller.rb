class Api::V1::ScheduleShowsController < ApplicationController  
  def destroy
    schedule = Schedule.find_by(id: params[:schedule_id])
    return record_not_found('Schedule not found.') unless schedule

    show = schedule.shows.find_by(id: params[:id]) 
    return record_not_found('Show not found in schedule.') unless show

    schedule.shows.destroy(show)
    schedule.reload

    render json: ScheduleSerializer.new(schedule), status: :ok
  end

  private

  def record_not_found(message)
    render json: ErrorSerializer.format_error(ErrorMessage.new(message, 404)), status: :not_found
  end
end