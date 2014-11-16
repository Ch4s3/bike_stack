class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)
    if needs_password?(@user, params)
      successfully_updated = true
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true

      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    params[:user][:password].present?
  end
end