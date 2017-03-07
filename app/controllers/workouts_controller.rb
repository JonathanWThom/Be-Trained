class WorkoutsController < ApplicationController
  ## limit who can access

  def show
    ##only show link if there is a next or previous
    ##add redirect too
    @athlete = Athlete.find(params[:athlete_id])
    @workout = Workout.find(params[:id])
    @tomorrow = Workout.where(date: @workout.date.prev_day)[0]
    @yesterday = Workout.where(date: @workout.date.next_day)[0]

    ## ONLY ALLOW ONE WORKOUT PER DAY?
    ## will next break if there are multiple workouts on a day?
  end

  def create
    @athlete = Athlete.find(params[:athlete_id])
    @workout = @athlete.workouts.new(workout_params)
    if @workout.save
      redirect_to coach_athlete_path(@athlete.coach, @athlete)
    else
      redirect_to coach_athlete_path(@athlete.coach, @athlete)
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:date, :workout, :coach_notes)
  end

end
