class WorkoutsController < ApplicationController
  before_action :authenticate_coach!, :only => [:create, :destroy]

  def show
    @athlete = Athlete.find(params[:athlete_id])
    ## helper method
    if (current_coach && (!current_coach.athletes.include?(@athlete))) || (current_athlete && (current_athlete != @athlete))
      redirect_to root_path
    else
      @workout = Workout.find(params[:id])
      ## put this in model
      @previous = Workout.where( "date < ?", @workout.date ).order( "date DESC" ).where(athlete_id: @athlete.id).first
      @next = Workout.where( "date > ?", @workout.date ).order( "date" ).where(athlete_id: @athlete.id).first
    end
  end

  def edit
    @athlete = Athlete.find(params[:athlete_id])
    if (current_coach && @athlete.coach != current_coach) || (current_athlete && @athlete != current_athlete)
      redirect_to root_path
    else
      @workout = Workout.find(params[:id])
      @workouts = @athlete.workouts.paginate(:page => params[:page], :per_page => 7).order(date: :desc)
      @previous = Workout.where( "date < ?", @workout.date ).order( "date DESC" ).where(athlete_id: @athlete.id).first
      @next = Workout.where( "date > ?", @workout.date ).order( "date" ).where(athlete_id: @athlete.id).first

      respond_to do |format|
        format.html { athlete_workout_path(@athlete, @workout) }
        format.js
      end
    end
  end

  def update
    @athlete = Athlete.find(params[:athlete_id])
    @workout = Workout.find(params[:id])
    if (current_coach && (current_coach != @athlete.coach)) || (current_athlete && (current_athlete != @athlete))
      redirect_to root_path
    elsif @athlete.workouts.where(date: update_params[:date]).length > 0
      flash[:notice] = "You may not add more than one workout for a day. Instead, edit the day's training to include multiple sessions."
      redirect_to athlete_workout_path(@athlete, @workout)
    else
      @previous = Workout.where( "date < ?", @workout.date ).order( "date DESC" ).where(athlete_id: @athlete.id).first
      @next = Workout.where( "date > ?", @workout.date ).order( "date" ).where(athlete_id: @athlete.id).first

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
      if @new_workout.date == @today_workout.first.date
        flash[:notice] = "You may not add more than one workout for a day. Instead, edit the day's training to include multiple sessions."
        redirect_to coach_athlete_path(@athlete.coach, @athlete)
      elsif @new_workout.save
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
