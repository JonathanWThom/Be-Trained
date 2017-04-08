class Athletes::SessionsController < Devise::SessionsController
  def new
    if current_coach
      flash[:notice] = "You will be signed out of your coach account."
    end
    super
  end

  def create
    if current_coach
      sign_out current_coach
    end
    super
  end
end
