require 'rails_helper'

RSpec.describe 'Schedule Endpoints', type: :request do
  describe 'GET all schedules' do
    it 'returns all schedules' do
      FactoryBot.create_list(:schedule, 3)

      get 'http://localhost:3000/api/v1/schedules'
      schedules = JSON.parse(response.body, symbolize_names:true)

      expect(response).to have_http_status(:ok)
      expect(schedules).to have_key(:data)
      expect(schedules[:data]).to be_an(Array)
      expect(schedules[:data][0]).to have_key(:id)
      expect(schedules[:data][0]).to have_key(:type)
      expect(schedules[:data][0][:type]).to eq('schedule')
      expect(schedules[:data][0]).to have_key(:attributes)
      expect(schedules[:data][0][:attributes]).to have_key(:name)
      expect(schedules[:data][0][:attributes]).to have_key(:description)
      expect(schedules[:data][0]).to have_key(:relationships)
      expect(schedules[:data][0][:relationships]).to have_key(:shows)
      expect(schedules[:data][0][:relationships][:shows]).to have_key(:data)
      expect(schedules[:data][0][:relationships][:shows][:data]).to be_an(Array)
    end
  end

  describe 'Remove show from schedule' do
    it 'removes a show from a schedule' do
      schedule = Schedule.create(name: 'Test', description: 'Test schedule description')
      show_to_remove = Show.create(artist_name: Faker::Music.unique.band, genre: Faker::Music.genre, location: "Main Stage", start_time: "2025-03-17T00:30:00.000Z", end_time: "2025-03-17T02:30:00.000Z")

      other_shows = FactoryBot.create_list(:show, 10)

      ([show_to_remove] + other_shows).each do |show|
        ScheduleShow.create(
          schedule: schedule,
          show: show
        )
      end

      expect(schedule.shows.count).to eq(11)

      delete "http://localhost:3000/api/v1/schedules/#{schedule.id}/shows/#{show_to_remove.id}"
      expect(response).to have_http_status(:ok)

      response = JSON.parse(response.body, symbolize_names:true)
    end
  end

end