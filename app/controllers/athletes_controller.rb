class AthletesController < ApplicationController
  before_action :authenticate_coach!, :only => [:invite, :update, :destroy]
  include ApplicationHelper
  expose :athlete


  def show
    if athlete
      @today_workout = athlete.workouts.today
      @link_filter = AutoHtml::Link.new(target: '_blank')
      @workout = athlete.workouts.new
      ## refactor this to model?
      @workouts = athlete.workouts.search(params[:search]).paginate(:page => params[:page], :per_page => 7).order(date: :desc)
      if invalid_user
        redirect_to new_athlete_session_path
      end
    else
      redirect_to root_path
    end
  end

  def invite
    @coach = Coach.find(params[:id])
    @email = params[:email]
    InviteMailer.invite_email(@coach, @email).deliver_now
    redirect_to coach_path(@coach)
  end

  def update
    @coach = Coach.find(params[:coach_id])
    if invalid_user
      redirect_to root_path
    else
      @athletes = @coach.athletes.confirmed
      @unconfirmed = @coach.athletes.unconfirmed
      if params[:accept] == "true"
        if athlete.update(confirmed: true)
          respond_to do |format|
            format.html { coach_path(athlete.coach) }
            format.js
          end
        end
      elsif params[:ignore] == "true"
        if @coach.athletes.destroy(athlete)
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
      if athlete.destroy && current_coach
        redirect_to coach_path(current_coach)
      elsif athlete.destroy && current_athlete
        redirect_to root_path
      end
    end
  end
end
