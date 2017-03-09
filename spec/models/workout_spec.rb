require 'rails_helper'

describe Workout do
  describe '.search' do
    it 'returns workouts including search term' do
      coach = create(:coach)
      athlete = coach.athletes.create(first_name: 'athlete', last_name: 'number 1', email: 'test@email.com', password: '123123', password_confirmation: '123123')
      workout = athlete.workouts.create(workout: 'this is the workout', date: Date.today)
      workout2 = athlete.workouts.create(workout: 'hey', date: Date.today)
      expect(Workout.search('hey')).to eq([workout2])
    end
  end
end
