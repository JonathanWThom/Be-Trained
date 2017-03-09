FactoryGirl.define do
  factory :workout do
    date Date.today
    workout 'This is the workout'
    athlete
  end
end
