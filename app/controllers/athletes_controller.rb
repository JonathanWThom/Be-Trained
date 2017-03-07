class AthletesController < ApplicationController
  def show
    @athlete = Athlete.find(params[:id])
    @today_workout = @athlete.workouts.where(date: Date.today)
    ##this is an array
    @workout = @athlete.workouts.new
    @workouts = @athlete.workouts
    binding.pry
    if current_coach == @athlete.coach || current_athlete == @athlete
    else
      redirect_to new_athlete_session_path
    end
  end

  def invite
    @coach = Coach.find(params[:id])
    @email = params[:email]
    InviteMailer.invite_email(@coach, @email).deliver_now

    redirect_to coach_path(@coach)
  end

  def update
    @athlete = Athlete.find(params[:id])
    @coach = Coach.find(params[:coach_id])
    @athletes = @coach.athletes.where(confirmed: true)
    @unconfirmed = @coach.athletes.where(confirmed: false)
    if params[:accept] == "true"
      if @athlete.update(confirmed: true)
        respond_to do |format|
          format.html { coach_path(@athlete.coach) }
          format.js
        end
      end
    elsif params[:ignore] == "true"
      if @coach.athletes.delete(@athlete)
        respond_to do |format|
          format.html { coach_path(@athlete.coach) }
          format.js
        end
      end
    else
      redirect_to coach_path(@athlete.coach)
    end
  end
end
