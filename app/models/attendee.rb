class Attendee < ApplicationRecord
  belongs_to :schedule

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end