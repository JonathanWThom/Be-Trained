class CoachesController < ApplicationController

  def show
    @coach = Coach.find(params[:id])
    if current_coach && current_coach == @coach
      @athletes = @coach.athletes.where(confirmed: true)
      @unconfirmed = @coach.athletes.where(confirmed: false)
    else
      redirect_to new_coach_session_path
    end
  end
end
