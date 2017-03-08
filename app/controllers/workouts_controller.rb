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

  def edit
    @athlete = Athlete.find(params[:athlete_id])
    @workout = Workout.find(params[:id])
    @tomorrow = Workout.where(date: @workout.date.prev_day)[0]
    @yesterday = Workout.where(date: @workout.date.next_day)[0]

    respond_to do |format|
      format.html { athlete_workout_path(@athlete, @workout) }
      format.js
    end
  end

  def update
    @athlete = Athlete.find(params[:athlete_id])
    @workout = Workout.find(params[:id])
    @tomorrow = Workout.where(date: @workout.date.prev_day)[0]
    @yesterday = Workout.where(date: @workout.date.next_day)[0]
    # @tomorrow = Workout.where(date: @workout.date.prev_day)[0]
    # @yesterday = Workout.where(date: @workout.date.next_day)[0]

    if @workout.update(update_params)
      respond_to do |format|
        format.html { athlete_workout_path(@athlete, @workout) }
        format.js
      end
    else
      redirect_to athlete_workout_path(@athlete, @workout)
    end
  end

  def create

    @athlete = Athlete.find(params[:athlete_id])
    @today_workout = @athlete.workouts.where(date: Date.today)
    @workouts = @athlete.workouts.paginate(:page => params[:page], :per_page => 7).order(date: :desc)
    @workout = @athlete.workouts.new
    @new_workout = @athlete.workouts.new(workout_params)
    if @new_workout.save
      respond_to do |format|
        format.html { coach_athlete_path(@athlete.coach, @athlete) }
        format.js
      end
    else
      redirect_to coach_athlete_path(@athlete.coach, @athlete)
    end
  end

  def destroy
    @athlete = Athlete.find(params[:athlete_id])
    @workout = Workout.find(params[:id])
    @workout.destroy
    redirect_to coach_athlete_path(@athlete.coach, @athlete)
  end

  private

  def workout_params
    params.require(:workout).permit(:date, :workout, :coach_notes)
  end

  def update_params
    params.require(:workout).permit(:results, :athlete_notes, :date, :workout, :coach_notes)
  end
end
