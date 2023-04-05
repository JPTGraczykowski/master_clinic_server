class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :json

  rescue_from Errors::NotAuthorizedError, with: :forbidden_response

  protected

  def render_response(record, status: :ok, &trigger)
    if yield trigger
      render(json: serialize_record(record), status: status)
    else
      render(json: { message: record.errors.full_messages },
             status: :unprocessable_entity)
    end
  end

  def serialize_record(record)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def proceed_deletion(record)
    if record.destroy
      head :ok
    else
      render(json: { message: record.errors.full_messages },
             status: :unprocessable_entity)
    end
  end

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
