class AthletesController < ApplicationController
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

    if @athlete.update(confirmed: true)
      respond_to do |format|
        format.html { coach_path(@athlete.coach) }
        format.js
      end
    else
      redirect_to coach_path(@athlete.coach)
    end
  end
end
