class CoachesController < ApplicationController
  before_action :authenticate_coach!
  def show
    @coach = Coach.find(params[:id])
    if current_coach && current_coach == @coach
      @athletes = @coach.athletes.confirmed
      @unconfirmed = @coach.athletes.unconfirmed
    else
      redirect_to new_coach_session_path
    end
  end
end
