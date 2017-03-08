class WorkoutsController < ApplicationController
  before_action :authenticate_coach!, :only => [:edit, :create, :destroy]

  def show
    @athlete = Athlete.find(params[:athlete_id])
    if (current_coach && (!current_coach.athletes.include?(@athlete))) || (current_athlete && (current_athlete != @athlete))
      redirect_to root_path
    else
      @workout = Workout.find(params[:id])
      ## put this in model
      @yesterday = Workout.where(date: @workout.date.prev_day).where(athlete_id: @athlete.id)[0]
      @tomorrow = Workout.where(date: @workout.date.next_day).where(athlete_id: @athlete.id)[0]
    end
  end

  def edit
    @athlete = Athlete.find(params[:athlete_id])
    if @athlete.coach != current_coach
      redirect_to new_coach_session_path
    else
      @workout = Workout.find(params[:id])
      @workouts = @athlete.workouts.paginate(:page => params[:page], :per_page => 7).order(date: :desc)
      @yesterday = Workout.where(date: @workout.date.prev_day).where(athlete_id: @athlete.id)[0]
      @tomorrow = Workout.where(date: @workout.date.next_day).where(athlete_id: @athlete.id)[0]

      respond_to do |format|
        format.html { athlete_workout_path(@athlete, @workout) }
        format.js
      end
    end
  end

  def update
    @athlete = Athlete.find(params[:athlete_id])
    if (current_coach && (current_coach != @athlete.coach)) || (current_athlete && (current_athlete != @athlete))
      redirect_to root_path
    else
      @workout = Workout.find(params[:id])
      @yesterday = Workout.where(date: @workout.date.prev_day).where(athlete_id: @athlete.id)[0]
      @tomorrow = Workout.where(date: @workout.date.next_day).where(athlete_id: @athlete.id)[0]

      if @workout.update(update_params)
        respond_to do |format|
          format.html { athlete_workout_path(@athlete, @workout) }
          format.js
        end
      else
        redirect_to athlete_workout_path(@athlete, @workout)
      end
    end
  end

  def create
    @athlete = Athlete.find(params[:athlete_id])
    if current_coach != @athlete.coach
      redirect_to new_coach_session_path
    else
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
  end

  def destroy
    @athlete = Athlete.find(params[:athlete_id])
    if current_coach != @athlete.coach
      redirect_to new_coach_session_path
    else
      @workout = Workout.find(params[:id])
      @workout.destroy
      redirect_to coach_athlete_path(@athlete.coach, @athlete)
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:date, :workout, :coach_notes)
  end

  def update_params
    params.require(:workout).permit(:results, :athlete_notes, :date, :workout, :coach_notes)
  end
end
