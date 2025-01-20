require 'rails_helper'

RSpec.describe Schedule, type: :model do
  after(:all) do
    Schedule.delete_all
    Attendee.delete_all
    Show.delete_all
  end
end