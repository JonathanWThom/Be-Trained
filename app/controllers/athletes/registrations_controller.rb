class Athletes::RegistrationsController < Devise::RegistrationsController
    # before_filter :configure_sign_up_params, only: [:create]

private
  #
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :coach_id
  # end

  def after_sign_up_path_for(athlete)
    coach_athlete_path(athlete.coach, athlete)
  end

  def sign_up_params
    params.require(:athlete).permit(:email, :password, :password_confirmation, :coach_id)
  end

  def account_update_params
    params.require(:athlete).permit(:email, :password, :password_confirmation, :current_password, :coach_id)
  end
end
