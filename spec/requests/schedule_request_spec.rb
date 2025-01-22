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
      expect(schedules[:data][0][:attributes]).to have_key(:shows)
      expect(schedules[:data][0][:attributes][:shows]).to be_an(Array)
      expect(schedules[:data][0]).to have_key(:other_schedule_attendees)
      expect(schedules[:data][0][:other_schedule_attendees]).to be_an(Array)
    end
  end

  describe 'GET one schedule' do
    it 'returns a schedule by id' do
      schedule = FactoryBot.create(:schedule)
      FactoryBot.create_list(:schedule, 3)
      FactoryBot.create_list(:show, 5)
      FactoryBot.create_list(:schedule_show, 5, schedule: schedule)
      FactoryBot.create_list(:attendee, 10, schedule: schedule)

      get "http://localhost:3000/api/v1/schedules/#{schedule.id}"
      schedule = JSON.parse(response.body, symbolize_names:true)

      expect(response).to have_http_status(:ok)
      expect(schedule).to have_key(:data)
      expect(schedule[:data]).to have_key(:id)
      expect(schedule[:data]).to have_key(:type)
      expect(schedule[:data][:type]).to eq('schedule')
      expect(schedule[:data]).to have_key(:attributes)
      expect(schedule[:data][:attributes]).to have_key(:name)
      expect(schedule[:data][:attributes]).to have_key(:description)
      expect(schedule[:data][:attributes]).to have_key(:shows)
      expect(schedule[:data][:attributes][:shows][0]).to have_key(:id)
      expect(schedule[:data][:attributes][:shows][0]).to have_key(:artist_name)
      expect(schedule[:data][:attributes][:shows][0]).to have_key(:genre)
      expect(schedule[:data][:attributes][:shows][0]).to have_key(:location)
      expect(schedule[:data][:attributes][:shows][0]).to have_key(:start_time)
      expect(schedule[:data][:attributes][:shows][0]).to have_key(:end_time)
      expect(schedule[:data]).to have_key(:other_schedule_attendees)
      expect(schedule[:data][:other_schedule_attendees][0]).to have_key(:attendee_id)
      expect(schedule[:data][:other_schedule_attendees][0]).to have_key(:attendee_name)
      expect(schedule[:data][:other_schedule_attendees][0]).to have_key(:attendee_email)
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

      expect(schedule.shows).to_not include(show_to_remove)
      expect(schedule.shows.count).to eq(10)
    end
  end

  describe 'sad paths' do
    it 'returns an error if a schedule is not found' do
      schedule = FactoryBot.create(:schedule)
      FactoryBot.create_list(:schedule, 3)
      FactoryBot.create_list(:show, 5)
      FactoryBot.create_list(:schedule_show, 5, schedule: schedule)
      FactoryBot.create_list(:attendee, 10, schedule: schedule)

      get "http://localhost:3000/api/v1/schedules/999"
      schedule = JSON.parse(response.body, symbolize_names:true)

      expect(response).to have_http_status(:not_found)
      expect(schedule).to have_key(:errors)
      expect(schedule[:errors][0]).to have_key(:detail)
      expect(schedule[:errors][0][:detail]).to eq("Schedule not found")
    end
  end

  describe 'sad paths' do
    it 'returns an error if a show is not found in a schedule' do
      schedule = FactoryBot.create(:schedule)
      FactoryBot.create_list(:schedule, 3)
      FactoryBot.create_list(:show, 5)
      FactoryBot.create_list(:schedule_show, 5, schedule: schedule)
      FactoryBot.create_list(:attendee, 10, schedule: schedule)

      delete "http://localhost:3000/api/v1/schedules/999/shows/111"
      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to have_http_status(:not_found)
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors][0]).to have_key(:detail)
      expect(response_body[:errors][0][:detail]).to eq("Show not found in schedule")
    end
  end
end