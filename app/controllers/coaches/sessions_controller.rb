class Coaches::SessionsController < Devise::SessionsController
  def new
    if current_athlete
      flash[:notice] = "You will be signed out of your athlete account."
    end
    super
  end

  def create
    if current_athlete
      sign_out current_athlete
    end
    super
  end
end
