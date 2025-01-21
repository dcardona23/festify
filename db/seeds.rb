require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or find_or_create_byd alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_find_or_create_by_by!(name: genre_name)
#   end

ScheduleShow.destroy_all
Attendee.destroy_all
Schedule.destroy_all
Show.destroy_all

festival_dates = [
  Date.new(2025, 3, 14),
  Date.new(2025, 3, 15),
  Date.new(2025, 3, 16)
]

locations = [
  "Main Stage",
  "VIP Lounge", 
  "Grand Pavilion",
  "Amphitheater Stage",
  "Waterfront Stage"
]

adjectives = ["Rising", "Legendary", "Electric", "Global", "Acoustic"]
themes = ["Stars", "Rock", "Groove", "Rhythms", "Bliss", "Melodies"]
genres = ["indie music", "rock", "EDM", "world music", "ballads"]

def generate_show_times(date)
  start_time = Time.new(date.year, date.month, date.day, rand(10..22), [0, 30].sample)
  end_time = start_time + [30, 60, 90, 120].sample.minutes
  [start_time, end_time]
end

10.times do
  name = "#{adjectives.sample} #{themes.sample}"
  description = "Experience the best of #{genres.sample} with unforgettable performances."

  Schedule.find_or_create_by(
    name: name,
    description: description
  )
end

100.times do
  Attendee.find_or_create_by(
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    email: Faker::Internet.unique.email,
    schedule_id: Schedule.all.sample.id
  )
end

50.times do
  date = festival_dates.sample
  start_time, end_time = generate_show_times(date)

  Show.find_or_create_by(
    artist_name: Faker::Music.unique.band,
    genre: Faker::Music.genre,
    location: locations.sample,
    start_time: start_time,
    end_time: end_time
  )
end

Schedule.all.each do |schedule|
  random_shows = Show.all.sample(rand(3..7))
  random_shows.each do |show|
    ScheduleShow.find_or_create_by(
      schedule: schedule,
      show: show
    )
  end
end