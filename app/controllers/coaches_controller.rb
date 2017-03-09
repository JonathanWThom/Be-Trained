class CoachesController < ApplicationController
  before_action :authenticate_coach!
  expose :coach

  def show
    if current_coach && current_coach == coach
      @athletes = coach.athletes.confirmed
      @unconfirmed = coach.athletes.unconfirmed
    else
      redirect_to new_coach_session_path
    end
  end
end
