class Api::V1::SchedulesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    schedules = Schedule.all
    render json: ScheduleSerializer.format_schedules(schedules)
  end

  def show
    schedule = Schedule.find(params[:id])
    
    render json: ScheduleSerializer.format_schedule(schedule)
  end

  private 

  def record_not_found(exception)
    render json: ErrorSerializer.format_schedule_error, status: :not_found
  end
end