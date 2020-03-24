class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        pages_show_path
    end

    private
        def sign_in_required
            redirect_to new_user_session_url unless user_signed_in?
        end

        def configure_permitted_parameters
            #devise用のStrong Parameters設定
            devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
            devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
            devise_parameter_sanitizer.permit(:account_update, keys: [:username])
        end
end
