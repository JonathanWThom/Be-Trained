class AthletesController < ApplicationController
  def invite
    @coach = Coach.find(params[:id])
    @email = params[:email]
    InviteMailer.invite_email(@coach, @email).deliver_now

    redirect_to coach_path(@coach)
  end
end
