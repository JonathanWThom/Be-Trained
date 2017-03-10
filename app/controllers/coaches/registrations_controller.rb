class Coaches::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
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
