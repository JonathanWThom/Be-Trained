FactoryGirl.define do
  factory :athlete do
    email 'athlete@athlete.com'
    first_name 'Athlete'
    last_name 'Athleterton'
    password '123123'
    password_confirmation '123123'
    coach
  end
end
