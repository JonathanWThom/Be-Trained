class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(coach)
    coach_path(current_coach)
  end

  def after_sign_in_path_for(athlete)
    coach_athlete_path(athlete.coach, athlete)
  end
end
