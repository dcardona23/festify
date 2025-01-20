require 'rails_helper'

FactoryBot.define do
  factory :attendee do
    first_name { 'Susie' }
    last_name { 'Jackson' }
    email { Faker::Internet.unique.email }
  end
end

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
    it { should have_many(:schedule_attendees) }
    it { should have_many(:schedules) }
    it { should have_many(:shows) }
  end
end