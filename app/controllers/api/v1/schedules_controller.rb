class Api::V1::SchedulesController < ApplicationController
  def index
    schedules = Schedule.all
    render json: ScheduleSerializer.new(Schedule.all)
  end
end