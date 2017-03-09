require 'rails_helper'

describe 'the coaches path' do
  it 'will show a coach\'s athletes' do
    coach = create(:coach)
    login_as(coach, :scope => :coach)
    athlete = coach.athletes.create(first_name: 'Jim', last_name: 'Bob', email: 'jim@bob.com', password: '123123', password_confirmation: '123123')
    visit coach_path(coach)
    expect(page).to have_content('Jim Bob')
  end
end
