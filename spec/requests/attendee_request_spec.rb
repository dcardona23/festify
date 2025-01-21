require 'rails_helper'

RSpec.describe 'Attendee Endpoints', type: :request do
  describe 'GET all attendees' do
    it 'returns all attendees' do
      FactoryBot.create_list(:attendee, 3)

      get 'http://localhost:3000/api/v1/attendees'
      attendees = JSON.parse(response.body, symbolize_names:true)

      expect(response).to have_http_status(:ok)
      expect(attendees).to have_key(:data)
      expect(attendees[:data]).to be_an(Array)
      expect(attendees[:data][0]).to have_key(:id)
      expect(attendees[:data][0]).to have_key(:type)
      expect(attendees[:data][0][:type]).to eq('attendee')
      expect(attendees[:data][0]).to have_key(:attributes)
      expect(attendees[:data][0][:attributes]).to have_key(:first_name)
      expect(attendees[:data][0][:attributes]).to have_key(:last_name)
      expect(attendees[:data][0][:attributes]).to have_key(:email)
      expect(attendees[:data][0][:attributes]).to have_key(:schedule_id)
    end
  end

  describe 'GET an attendee/s schedule' do
    it 'returns an attendee/s schedule, including the show(s) involved and other users with the same schedule' do
      schedule = Schedule.create(name: 'Test', description: 'Test schedule description')
      attendee = Attendee.create(first_name: 'Susie', last_name: 'Jackson', email: 'test@test.com', schedule_id: schedule.id)
      FactoryBot.create_list(:attendee, 10, schedule_id: schedule.id)

      get "http://localhost:3000/api/v1/attendees/#{attendee.id}/schedules"
      attendees = JSON.parse(response.body, symbolize_names:true)
      
      expect(response).to be_successful
      expect(attendees).to have_key(:data)
      expect(attendees[:data]).to be_an(Array)
      expect(attendees[:data][0]).to have_key(:attendee_id)
      expect(attendees[:data][0]).to have_key(:type)
      expect(attendees[:data][0][:type]).to eq('attendee schedule')
      expect(attendees[:data][0]).to have_key(:attributes)
      expect(attendees[:data][0][:attributes]).to have_key(:attendee_name)
      expect(attendees[:data][0][:attributes]).to have_key(:attendee_email)
      expect(attendees[:data][0][:attributes]).to have_key(:schedule)
      expect(attendees[:data][0][:attributes][:schedule]).to have_key(:schedule_name)
      expect(attendees[:data][0][:attributes][:schedule]).to have_key(:schedule_description)
      expect(attendees[:data][0][:attributes][:schedule]).to have_key(:shows)
      expect(attendees[:data][0][:attributes][:schedule][:shows]).to be_an(Array)
      expect(attendees[:data][0][:attributes]).to have_key(:other_schedule_attendees)
      expect(attendees[:data][0][:attributes][:other_schedule_attendees]).to be_an(Array)
    end
  end
end