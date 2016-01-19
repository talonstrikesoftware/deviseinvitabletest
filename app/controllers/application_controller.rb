class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    #Only add some parameters
    # TODO: Are both these needed?
    devise_parameter_sanitizer.for(:accept_invitation).concat [:email]
    #Override accpeted parameters
    devise_parameter_sanitizer.for(:accept_invitation) do |u| 
      u.permit(:email, :password, :password_confirmation, :invitation_token)
    end
  end
end
