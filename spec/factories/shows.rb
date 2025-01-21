FactoryBot.define do
  factory :show do
    artist_name { Faker::Music.unique.band }
    genre { Faker::Music.genre }
    location { 'Main Stage'}
    start_time { "2025-03-17T00:30:00.000Z" }
    end_time { "2025-03-17T02:30:00.000Z" }
  end
end