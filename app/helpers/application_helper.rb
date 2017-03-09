module ApplicationHelper
  def invalid_user
    if (!current_coach && !current_athlete) || (current_coach && (current_coach != @athlete.coach)) || (current_athlete && (current_athlete != @athlete))
      true
    end
  end

  def invalid_workout_user
    if (!current_coach && !current_athlete) || (current_coach && (!current_coach.athletes.include?(@athlete))) || (current_athlete && (current_athlete != @athlete))
      true
    end
  end
end
