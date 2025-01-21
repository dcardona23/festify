class AttendeeSerializer
  include JSONAPI::Serializer
  attributes :first_name, :last_name, :email, :schedule_id
end