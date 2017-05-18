require "rails_helper"

describe "the workouts path" do
  ## not passing
  it "will show a workout to a valid user" do
    workout = create(:workout)
    athlete = workout.athlete
    login_as(athlete, :scope => :athlete)
    visit "/athletes/1/workouts/1"
    expect(page).to have_content("This is the workout")
  end

  it "will not show a workout to an invalid user" do
    workout = create(:workout)
    visit athlete_workout_path(workout.athlete, workout)
    expect(page).to_not have_content("This is the workout")
  end

  it "will allow a coach to edit a workout", js: true do
    coach = create(:coach)
    athlete = create(:athlete, coach_id: coach.id)
    workout = create(:workout)
    login_as(coach, :scope => :coach)
    visit athlete_workout_path(workout.athlete, workout)
    click_on "Edit Workout"
    fill_in "workout", with: "I have edited the workout"
    click_on "Update Workout"
    expect(page).to have_content("I have edited the workout")
  end
end
