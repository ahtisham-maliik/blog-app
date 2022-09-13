class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
