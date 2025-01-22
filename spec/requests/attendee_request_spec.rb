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
      attendee_response = JSON.parse(response.body, symbolize_names:true)

      expect(response).to be_successful
      expect(attendee_response).to have_key(:data)
      expect(attendee_response[:data]).to be_an(Array)
      expect(attendee_response[:data][0]).to have_key(:attendee_id)
      expect(attendee_response[:data][0]).to have_key(:type)
      expect(attendee_response[:data][0][:type]).to eq('attendee schedule')
      expect(attendee_response[:data][0]).to have_key(:attributes)
      expect(attendee_response[:data][0][:attributes]).to have_key(:attendee_name)
      expect(attendee_response[:data][0][:attributes]).to have_key(:attendee_email)
      expect(attendee_response[:data][0][:attributes]).to have_key(:schedule)
      expect(attendee_response[:data][0][:attributes][:schedule]).to have_key(:schedule_name)
      expect(attendee_response[:data][0][:attributes][:schedule]).to have_key(:schedule_description)
      expect(attendee_response[:data][0][:attributes][:schedule]).to have_key(:shows)
      expect(attendee_response[:data][0][:attributes][:schedule][:shows]).to be_an(Array)
      expect(attendee_response[:data][0][:attributes]).to have_key(:other_schedule_attendees)
      expect(attendee_response[:data][0][:attributes][:other_schedule_attendees]).to be_an(Array)
    end
  end

  describe 'sad paths' do
    it 'returns an error if an attendee is not found' do
      schedule = FactoryBot.create(:schedule)
      FactoryBot.create_list(:schedule, 3)
      FactoryBot.create_list(:show, 5)
      FactoryBot.create_list(:schedule_show, 5, schedule: schedule)
      FactoryBot.create_list(:attendee, 10, schedule: schedule)

      get "http://localhost:3000/api/v1/attendees/999"
      response_body = JSON.parse(response.body, symbolize_names:true)

      expect(response).to have_http_status(:not_found)
      expect(response_body).to have_key(:errors)
      expect(response_body[:errors][0]).to have_key(:detail)
      expect(response_body[:errors][0][:detail]).to eq("Attendee not found")
    end
  end
end