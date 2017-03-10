class Athletes::PasswordsController < Devise::PasswordsController

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      if resource_params[:email] == ''
        flash[:notice] = "Email can\'t be blank"
      else
        flash[:notice] = "Email not found"
      end
      respond_with(resource)
    end
  end

end
