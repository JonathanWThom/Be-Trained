module ApplicationHelper
  def invalid_user
    if (!current_coach && !current_athlete) || (current_coach && (current_coach != athlete.coach)) || (current_athlete && (current_athlete != athlete))
      true
    end
  end

  def invalid_workout_user
    if (!current_coach && !current_athlete) || (current_coach && (!current_coach.athletes.include?(athlete))) || (current_athlete && (current_athlete != athlete))
      true
    end
  end

  def invalid_date(workout, athlete, date)
    if (workout.date.strftime("%Y-%m-%d") != date) && (athlete.workouts.date_number(date) > 0)
      true
    end
  end

  def sortable(column, title = nil)
    title ||= column.capitalize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
end
