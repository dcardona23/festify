require 'rails_helper'

RSpec.describe Attendee, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }

    it 'validates uniqueness of email' do
      attendee1 = create(:attendee, email: 'test@example.com')
      attendee2 = build(:attendee, email: 'test@example.com')

      expect(attendee1.valid?).to be true
      expect(attendee2.valid?).to be false
      expect(attendee2.save).to be false
    end
  end

  describe 'relationships' do
    it { should belong_to(:schedule) }
  end

  describe 'instance methods' do
    before(:each) do
      @schedule = create(:schedule)
      @attendee1 = create(:attendee, schedule: @schedule)
      @other_attendees = create_list(:attendee, 10, schedule: @schedule)
      @show1 = create(:show)
      @show2 = create(:show)
      @show3 = create(:show)
      @schedule_show1 = create(:schedule_show, show: @show1, schedule: @schedule )
      @schedule_show2 = create(:schedule_show, show: @show2, schedule: @schedule )
      @schedule_show3 = create(:schedule_show, show: @show3, schedule: @schedule )
    end

    it 'gets an attendee/s schedule' do
      attendee_schedule = @attendee1.get_attendee_schedule

      expect(attendee_schedule.id).to eq(@attendee1.schedule.id)
      expect(attendee_schedule.name).to eq(@attendee1.schedule.name)
      expect(attendee_schedule.description).to eq(@attendee1.schedule.description)
    end

    it 'gets the shows for an attendee/s schedule' do
      attendee_shows = @attendee1.get_schedule_shows

      expect(attendee_shows[0].id).to eq(@show1.id)
      expect(attendee_shows[1].id).to eq(@show2.id)
      expect(attendee_shows[2].id).to eq(@show3.id)
      expect(attendee_shows[0].artist_name).to eq(@show1.artist_name)
      expect(attendee_shows[1].artist_name).to eq(@show2.artist_name)
      expect(attendee_shows[2].artist_name).to eq(@show3.artist_name)
      expect(attendee_shows[0].genre).to eq(@show1.genre)
      expect(attendee_shows[1].genre).to eq(@show2.genre)
      expect(attendee_shows[2].genre).to eq(@show3.genre)
      expect(attendee_shows[0].location).to eq(@show1.location)
      expect(attendee_shows[1].location).to eq(@show2.location)
      expect(attendee_shows[2].location).to eq(@show3.location)
      expect(attendee_shows[0].start_time).to eq(@show1.start_time)
      expect(attendee_shows[1].start_time).to eq(@show2.start_time)
      expect(attendee_shows[2].start_time).to eq(@show3.start_time)
      expect(attendee_shows[0].end_time).to eq(@show1.end_time)
      expect(attendee_shows[1].end_time).to eq(@show2.end_time)
      expect(attendee_shows[2].end_time).to eq(@show3.end_time)
    end

    it 'gets the other attendees for an attendee/s schedule' do
      schedule_attendees = @attendee1.get_schedule_attendees

      expect(schedule_attendees.length).to eq(10)
      expect(schedule_attendees).to include(*@other_attendees)
    end
  end
end