class ApplicationController < ActionController::Base
  config.time_zone = :local
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
    if resource.is_a?(Coach)
      coach_path(current_coach)
    else
      coach_athlete_path(current_athlete.coach, current_athlete)
    end
  end

end
