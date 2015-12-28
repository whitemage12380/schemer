class ApplicationController < ActionController::Base
  # Specify the correct layout using the logic in the below specify_layout method
  layout :specify_layout
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Before actions
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  # Handle strong parameters for custom Devise user attributes
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :display_name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :display_name, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :display_name, :email, :password, :password_confirmation, :current_password) }
  end

  # Show main layout unless signed out, in which case use sign in layout
  def specify_layout
    if devise_controller?
      #if is_a?(RegistrationsController)
      if !(current_user.nil?)
        "application"
      else
        "sign_in"
      end
    else
      "application"
    end
  end
end
