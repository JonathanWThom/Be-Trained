module ApplicationHelper
  def valid_user
    if !current_coach || !current_athlete || (current_coach && (current_coach != @athlete.coach)) || (current_athlete && (current_athlete != @athlete))
      true
    end
  end
end
