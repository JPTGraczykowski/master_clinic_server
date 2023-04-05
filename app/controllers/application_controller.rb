class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :authenticate_user!

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

  def authenticate_admin!
    unless current_user.role_admin?
      raise Errors::NotAuthorizedError
    end
  end

  def forbidden_response
    head :forbidden
  end
end
