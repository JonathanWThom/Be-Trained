class AthletesController < ApplicationController
  before_action :authenticate_coach!, :only => [:invite, :update]
  include ApplicationHelper
  helper_method :sort_column, :sort_direction
  expose :athlete
  expose :coach
  expose :exercises, ->{ athlete.exercises.order(sort_column + " " + sort_direction) }

  def show
    if athlete
      @today_workout = Workout.today(athlete)
      @link_filter = AutoHtml::Link.new(target: '_blank')
      @workout = athlete.workouts.new
      @workouts = athlete.workouts.search(params[:search]).paginate(:page => params[:page], :per_page => 7).order(date: :desc)
      if invalid_user
        redirect_to new_athlete_session_path
      end
    else
      redirect_to root_path
    end
  end

  def invite
    @email = params[:email]
    if @email != ''
      if InviteMailer.invite_email(coach, @email).deliver_now
        flash[:notice] = "You sent an invitation to #{@email}."
        redirect_to coach_path(coach)
      else
        flash[:notice] = "Something went wrong with your invitation."
        redirect_to coach_path(coach)
      end
    else
      flash[:notice] = "Please add an email to invite an athlete."
      redirect_to coach_path(coach)
    end
  end

  def update
    if invalid_user
      redirect_to root_path
    else
      @athletes = coach.athletes.confirmed
      @unconfirmed = coach.athletes.unconfirmed
      if params[:accept] == "true"
        if athlete.update(confirmed: true)
          respond_to do |format|
            format.html { coach_path(athlete.coach) }
            format.js
          end
        end
      elsif params[:ignore] == "true"
        if coach.athletes.destroy(athlete)
          respond_to do |format|
            format.html { coach_path(athlete.coach) }
            format.js
          end
        end
      else
        redirect_to coach_path(athlete.coach)
      end
    end
  end

  def destroy
    if invalid_user
      redirect_to root_path
    else
      if current_coach
        if athlete.destroy
          redirect_to coach_path(current_coach)
        end
      elsif current_athlete
        if athlete.destroy
          redirect_to root_path
        end
      end
    end
  end

  private

  def sort_column
    Exercise.column_names.include?(params[:sort]) ? params[:sort] : "date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
