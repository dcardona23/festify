class ScheduleSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :shows
end