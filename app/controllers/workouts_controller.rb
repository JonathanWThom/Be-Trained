class WorkoutsController < ApplicationController
  ## limit who can access

  def show
    @athlete = Athlete.find(params[:athlete_id])
    @workout = Workout.find(params[:id])
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
