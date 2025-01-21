class ShowSerializer
  include JSONAPI::Serializer
  attributes :artist_name, :genre, :location, :start_time, :end_time 
end