require 'rails_helper'

## refactor all of this to use factories

describe Workout do
  describe '.search' do
    it 'returns workouts including search term' do
      ### use factories!!
      coach = create(:coach)
      athlete = coach.athletes.create(first_name: 'athlete', last_name: 'number 1', email: 'test@email.com', password: '123123', password_confirmation: '123123')
      workout = athlete.workouts.create(workout: 'this is the workout', date: Date.today)
      workout2 = athlete.workouts.create(workout: 'hey', date: Date.today)
      expect(Workout.search('hey')).to eq([workout2])
    end

    ## not sure how to pass in literally nothing and not have it be mad at me, but that's what I need to do to cover that code
    it 'returns all workouts if search empty' do
      coach = create(:coach)
      athlete = coach.athletes.create(first_name: 'athlete', last_name: 'number 1', email: 'test@email.com', password: '123123', password_confirmation: '123123')
      workout = athlete.workouts.create(workout: 'this is the workout', date: Date.today)
      workout2 = athlete.workouts.create(workout: 'hey', date: Date.today)
      expect(Workout.search('')).to eq([workout, workout2])
    end
  end

  describe '#previous' do
    it 'returns the previous, or closest previous workout by date' do
      coach = create(:coach)
      athlete = coach.athletes.create(first_name: 'athlete', last_name: 'number 1', email: 'test@email.com', password: '123123', password_confirmation: '123123')
      today = Date.today
      workout = athlete.workouts.create(workout: 'this is the workout', date: Date.today)
      workout2 = athlete.workouts.create(workout: 'hey', date: today.prev_day)
      expect(Workout.previous(today)).to eq(workout2)
    end
  end

  describe '#next' do
    it 'returns the next, or closest next workout by date' do
      coach = create(:coach)
      athlete = coach.athletes.create(first_name: 'athlete', last_name: 'number 1', email: 'test@email.com', password: '123123', password_confirmation: '123123')
      today = Date.today
      workout = athlete.workouts.create(workout: 'this is the workout', date: Date.today)
      workout2 = athlete.workouts.create(workout: 'hey', date: today.next_day)
      expect(Workout.next(today)).to eq(workout2)
    end
  end

  describe '#date_number' do
    it 'returns the number of workouts with that same date' do
      coach = create(:coach)
      athlete = coach.athletes.create(first_name: 'athlete', last_name: 'number 1', email: 'test@email.com', password: '123123', password_confirmation: '123123')
      today = Date.today
      workout = athlete.workouts.create(workout: 'this is the workout', date: Date.today)
      workout2 = athlete.workouts.create(workout: 'hey', date: today.next_day)
      expect(Workout.date_number(today)).to eq(1)
    end
  end
end
