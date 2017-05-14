FactoryGirl.define do
  factory :exercise do
    name 'Back Squat'
    record '400'
    date Date.today
    unit 'Pounds'
    athlete
  end
end
