FactoryBot.define do
  factory :attendee do
    first_name { 'Susie' }
    last_name { 'Jackson' }
    email { Faker::Internet.unique.email }
    schedule 
  end
end