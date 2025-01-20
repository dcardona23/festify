require 'rails_helper'

RSpec.describe Schedule, type: :model do
  describe 'relationships' do
    it { should have_many(:schedule_attendees) }
    it { should have_many(:schedule_shows) }
    it { should have_many(:shows) }
    it { should have_many(:attendees) }
  end
end