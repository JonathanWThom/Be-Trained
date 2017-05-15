require "rails_helper"

describe "the personal records path", js: true do
  before(:each) do
    @athlete = create(:athlete)
    login_as(@athlete)
  end

  it "will add a new personal record" do
    visit coach_athlete_path(@athlete.coach, @athlete)
    click_on "Add a New Record"
    fill_in "Name", with: "Back Squat"
    fill_in "Record", with: "400"
    select "Pounds", from: "Unit"
    click_on "Post Record"
    expect(page).to have_content("Update Delete Show History")
  end

  it "will update a new record" do
    exercise = create(:exercise, athlete_id: @athlete.id)
    visit coach_athlete_path(@athlete.coach, @athlete)
    click_on "Update"
    fill_in "Record", with: "500"
    click_on "Post Record"
    expect(page).to have_content("500")
  end
end
