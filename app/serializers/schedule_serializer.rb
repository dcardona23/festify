class ScheduleSerializer
  include JSONAPI::Serializer
  attributes :name, :description 
  has_many :shows
  has_many :attendees
end