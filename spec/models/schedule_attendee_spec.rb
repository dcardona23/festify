require 'rails_helper'

RSpec.describe ScheduleAttendee, type: :model do
  
  describe 'relationships' do
    it { should belong_to(:schedule) }
    it { should belong_to(:attendee) }
  end
end