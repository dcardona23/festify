class Api::V1::ScheduleShowsController < ApplicationController  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def destroy
    schedule = Schedule.find_by(id: params[:schedule_id])
    return record_not_found('Schedule not found.') unless schedule

    show = schedule.shows.find(params[:id]) 
    return record_not_found('Show not found in schedule.') unless show

    schedule.shows.destroy(show)
    schedule.reload

    render json: ScheduleSerializer.new(schedule), status: :ok
  end

  private

  def record_not_found(exception)
    render json: ErrorSerializer.format_show_error, status: :not_found
  end
end