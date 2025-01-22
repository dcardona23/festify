class Api::V1::SchedulesController < ApplicationController
  def index
    schedules = Schedule.all
    render json: ScheduleSerializer.new(Schedule.all)
  end

  def show
    schedule = Schedule.find_by(id: params[:id])
    render json: ScheduleSerializer.new(schedule)
  end
end