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
    end
  end
end