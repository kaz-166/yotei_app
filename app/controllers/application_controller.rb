class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_locale
    add_flash_types :success, :info, :warning, :danger

    def set_locale
        I18n.locale = locale
    end

    def locale
        if user_signed_in?
            @locale ||= User.get_locale(current_user.id) || I18n.default_locale
        else
            @locale ||= I18n.default_locale
        end
    end

    def default_url_options(options={})
        options.merge(locale: locale)
    end

    def after_sign_in_path_for(resource)
        pages_show_path
    end

    class Forbidden < ActionController::ActionControllerError
    end
    rescue_from Forbidden, with: :rescue403


    private
        def rescue403(e)
            @exception = e
            render template: 'errors/forbidden', status: 403
        end
        
        def sign_in_required
            redirect_to new_user_session_url unless user_signed_in?
        end

        def configure_permitted_parameters
            # devise用のStrong Parameters設定
            devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :img])
            devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :email, :username])
            devise_parameter_sanitizer.permit(:account_update, keys: [:username, :img])
        end
end
