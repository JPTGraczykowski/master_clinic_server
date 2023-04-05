class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :json

  rescue_from Errors::NotAuthorizedError, with: :forbidden_response

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: user_sign_up_keys)
    devise_parameter_sanitizer.permit(:account_update, keys: user_account_update_keys)
  end

  def user_sign_up_keys
    [
      :first_name,
      :last_name,
      :telephone,
    ]
  end

  def user_account_update_keys
    [
      :first_name,
      :last_name,
      :telephone,
      :active,
      :cabinet_id,
    ]
  end

  def authenticate_admin!
    unless current_user.role_admin?
      raise Errors::NotAuthorizedError
    end
  end

  def forbidden_response
    head :forbidden
  end
end
