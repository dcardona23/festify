require 'rails_helper'

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