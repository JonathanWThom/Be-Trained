require 'rails_helper'

RSpec.describe Athlete, type: :model do
  it { should belong_to :coach }
  it { should have_many :workouts }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  describe '.confirmed' do
    it 'will return only confirmed athletes' do
      coach = create(:coach)
      athlete = coach.athletes.create(first_name: 'athlete', last_name: 'number 1', email: 'test@email.com', password: '123123', password_confirmation: '123123', confirmed: true)
      athlete2 = coach.athletes.create(first_name: 'athlete', last_name: 'number 1', email: 'test@email.com', password: '123123', password_confirmation: '123123', confirmed: false)
      expect(Athlete.confirmed).to eq([athlete])
    end
  end
end
