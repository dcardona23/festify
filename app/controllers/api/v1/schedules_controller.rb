class Api::V1::SchedulesController < ApplicationController
  def index
    schedules = Schedule.all
    render json: ScheduleSerializer.format_schedules(schedules)
  end

  def show
    schedule = Schedule.find_by(id: params[:id])
    render json: ScheduleSerializer.format_schedule(schedule)
  end
end