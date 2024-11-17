class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # Runs Devise-specific configuration and authentication checks before any action.
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected
  # Configures additional permitted parameters for Devise actions (sign up and account update).
  # Allows additional fields: username, phone number, full name, profile photo, bio, and privacy setting.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :phone_number, :full_name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :phone_number, :full_name, :profile_photo, :bio, :private ])
  end
end
