class AthletesController < ApplicationController
  def invite
    @coach = Coach.find(params[:id])


    redirect_to coach_path(@coach)
  end
end
