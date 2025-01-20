require 'rails_helper'

start_time = Faker::Time.forward(days: 30, period: :afternoon)
end_time = start_time + rand(30..120).minutes

FactoryBot.define do
  factory :show do
    artist_name { Faker::Music.band }
    location { Faker::Address.community }
    start_time { start_time }
    end_time { end_time }
    last_name { 'Jackson' }
    email { Faker::Internet.unique.email }
  end
end

RSpec.describe Show, type: :model do
  
  describe 'validations' do
    it { should validate_presence_of(:artist_name) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
  end

  describe 'relationships' do
    it { should have_many(:schedule_shows) }
    it { should have_many(:schedules) }
  end
end