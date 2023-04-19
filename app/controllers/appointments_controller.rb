class AppointmentsController < ApplicationController
  before_action :scope_appointments, only: [:index]
  before_action :set_appointment, only: [:show, :update, :destroy]

  def index
    @appointments = if params[:when_appointment] == 'upcoming'
      @appointments.upcoming
    else params[:when_appointment] == 'past'
      @appointments.past
    end

    @appointments = @appointments
                      .includes(:doctor, :cabinet, :patient, :specialty)
                      .order(:appointment_datetime)

    render_response(@appointments) { true }
  end

  def show
    render_response(@appointment) { true }
  end

  def create
    @appointment = Appointment.new(crate_appointment_params)

    render_response(@appointment, status: :created) { @appointment.save }
  end

  def update
    @appointment.assign_attributes(update_appointment_params)

    render_response(@appointment) { !current_user.role_patient? && @appointment.save }
  end

  def destroy
    if !current_user.role_patient? && @appointment.destroy
      head :ok
    else
      render(json: { message: @appointment.errors.full_messages },
             status: :unprocessable_entity)
    end
  end

  private

  def scope_appointments
    if current_user.role_admin?
      @appointments = Appointment.all
    elsif current_user.role_doctor?
      @appointments = Appointment.with_doctor_id(current_user.id)
    elsif current_user.role_patient?
      @appointments = Appointment.with_patient_id(current_user.id)
    end
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def serialize_record(record)
    AppointmentSerializer.new(record).serializable_hash
  end

  def crate_appointment_params
    params.require(:appointment).permit(
      :specialty_id,
      :doctor_id,
      :patient_id,
      :datetime_slot,
      :description,
    )
  end

  def update_appointment_params
    params.require(:appointment).permit(
      :before_visit,
      :cabinet_id,
    )
  end
end
