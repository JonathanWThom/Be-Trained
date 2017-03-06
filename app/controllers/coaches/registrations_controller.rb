class Coaches::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(coach)
    coach_path(current_coach)
  end

  def sign_up_params
    params.require(:coach).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

  def account_update_params
    params.require(:coach).permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name)
  end

end
