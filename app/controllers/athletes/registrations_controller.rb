class Athletes::RegistrationsController < Devise::RegistrationsController
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
      ## change this to include real error messages eventually
      flash[:notice] = "There were some problems with your registration."
      redirect_back(fallback_location: root_path)
    end
  end

protected


  def after_sign_up_path_for(athlete)
    coach_athlete_path(athlete.coach, athlete)
  end

  def sign_up_params
    params.require(:athlete).permit(:email, :password, :password_confirmation, :coach_id, :first_name, :last_name)
  end

  def account_update_params
    params.require(:athlete).permit(:email, :password, :password_confirmation, :current_password, :coach_id, :first_name, :last_name)
  end
end
