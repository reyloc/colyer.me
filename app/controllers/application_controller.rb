class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def admin?
    current_user.admin?
  end

  def limit_actions
    unless admin?
      redirect_to root_path, notice: "You are not authorized"
    end
  end

  helper_method :admin?, :limit_actions

  protected

  def configure_permitted_parameters
    signup_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :full_name]
    update_attrs = [:username, :email, :password, :password_confirmation, :current_password, :full_name]
    devise_parameter_sanitizer.permit :sign_up, keys: signup_attrs
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

end
