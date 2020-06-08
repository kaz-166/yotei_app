# deviseのConfirmationsControllerをオーバーライド
class ConfirmationsController < Devise::ConfirmationsController
    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      yield resource if block_given?
      
      if resource.errors.empty?
        set_flash_message(:notice, :confirmed) if is_flashing_format?
        sign_in(resource) # <= THIS LINE ADDED
        redirect_to after_confirmation_path_for(resource_name, resource)
      else
        render :new 
      end
    end
  end