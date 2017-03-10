class WorkoutsController < ApplicationController
  before_action :authenticate_coach!, :only => [:create, :destroy]
  include ApplicationHelper
  expose :athlete

  def show
    if invalid_workout_user
      redirect_to root_path
    else
      @workout = Workout.find(params[:id])
      @link_filter = AutoHtml::Link.new(target: '_blank')
      @previous = athlete.workouts.previous(@workout.date)
      @next = athlete.workouts.next(@workout.date)
    end
  end

  def edit
    if invalid_workout_user
      redirect_to root_path
    else
      @workout = Workout.find(params[:id])
      @link_filter = AutoHtml::Link.new(target: '_blank')
      ## put below in model?
      @workouts = athlete.workouts.paginate(:page => params[:page], :per_page => 7).order(date: :desc)
      @previous = athlete.workouts.previous(@workout.date)
      @next = athlete.workouts.next(@workout.date)
      respond_to do |format|
        format.html { athlete_workout_path(athlete, @workout) }
        format.js
      end
    end
  end

  def update
    @workout = Workout.find(params[:id])
    @link_filter = AutoHtml::Link.new(target: '_blank')
    if invalid_workout_user
      redirect_to root_path
    elsif invalid_date(@workout, athlete, update_params[:date])
      flash[:notice] = "You may not add more than one workout for a day. Instead, edit the day's training to include multiple sessions."
      redirect_to athlete_workout_path(athlete, @workout)
    else
      @previous = athlete.workouts.previous(@workout.date)
      @next = athlete.workouts.next(@workout.date)
      if @workout.update(update_params)
        respond_to do |format|
          format.html { athlete_workout_path(athlete, @workout) }
          format.js
        end
      else
        redirect_to athlete_workout_path(athlete, @workout)
      end
    end
  end

  def create
    if current_coach != athlete.coach
      redirect_to new_coach_session_path
    else
      @today_workout = athlete.workouts.where(date: Date.today)

      @workouts = athlete.workouts.paginate(:page => params[:page], :per_page => 7).order(date: :desc)
      @workout = athlete.workouts.new
      @link_filter = AutoHtml::Link.new(target: '_blank')
      @new_workout = athlete.workouts.new(workout_params)
      if athlete.workouts.date_number(workout_params[:date]) > 0
        flash[:notice] = "You may not add more than one workout for a day. Instead, edit the day's training to include multiple sessions."
        redirect_to coach_athlete_path(athlete.coach, athlete)
      elsif @new_workout.save
        respond_to do |format|
          format.html { coach_athlete_path(athlete.coach, athlete) }
          format.js
        end
      else
        redirect_to coach_athlete_path(athlete.coach, athlete)
      end
    end
  end

  def destroy
    if current_coach != athlete.coach
      redirect_to new_coach_session_path
    else
      @link_filter = AutoHtml::Link.new(target: '_blank')
      @workout = Workout.find(params[:id])
      @workout.destroy
      redirect_to coach_athlete_path(athlete.coach, athlete)
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
