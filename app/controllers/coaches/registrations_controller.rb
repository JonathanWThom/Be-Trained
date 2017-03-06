class Coaches::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(coach)
    coach_path(current_coach)
  end

end
