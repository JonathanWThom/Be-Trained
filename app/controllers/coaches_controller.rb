class CoachesController < ApplicationController
  def show
    @coach = Coach.find(params[:id])
  end
end
