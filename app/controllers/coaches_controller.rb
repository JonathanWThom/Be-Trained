class CoachesController < ApplicationController
  def show
    @coach = Coach.find(params[:id])
    @athletes = @coach.athletes
  end
end
