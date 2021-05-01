class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:gender, :eng_name, :chn_name, :gender, :phone_no, :language, :locality, :email, :password])
            devise_parameter_sanitizer.permit(:account_update, keys: [:gender, :eng_name, :chn_name, :gender, :phone_no, :language, :locality, :email, :password, :current_password])
        end

        def check_if_admin
            if signed_in?
                if current_user.admin
                    #is admin and able to proceed
                else
                    flash[:alert] = "Only administrator can perform this action!"  
                      redirect_to main_app.root_path 
                end
              else	  		
                  redirect_to main_app.root_path
              end
        end
end


