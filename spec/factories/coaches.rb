FactoryGirl.define do
  factory :coach do
    email 'coach@coach.com'
    first_name 'Coach'
    last_name 'Coacherton'
    password '123123'
    password_confirmation '123123'
  end
end
