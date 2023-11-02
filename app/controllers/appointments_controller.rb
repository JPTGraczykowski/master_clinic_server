class AppointmentsController < ApplicationController
  before_action :authenticate_not_patient!, only: [:destroy]
  before_action :set_appointments_collection, only: [:index]
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

    render_response(@appointment) { @appointment.save }
  end

  def destroy
    proceed_deletion(@appointment)
  end

  private

  def scope_appointments
    if current_user.role_admin?
      Appointment.all
    elsif current_user.role_doctor?
      Appointment.with_doctor_id(current_user.id)
    elsif current_user.role_patient?
      Appointment.with_patient_id(current_user.id)
    end
  end

  def set_appointments_collection
    @appointments = scope_appointments
  end

  def set_appointment
    @appointment = scope_appointments.find(params[:id])
  end

  def serialize_record(record)
    AppointmentSerializer.new(record).serializable_hash
  end

  def param_patient_id
    params[:appointment][:patient_id] || current_user.id
  end

  def crate_appointment_params
    params.require(:appointment).permit(
      :specialty_id,
      :doctor_id,
      :datetime_slot_id,
      :description,
    ).merge(
      patient_id: param_patient_id,
    )
  end

  def update_appointment_params
    params.require(:appointment).permit(
      :before_visit,
      :cabinet_id,
      :description,
    )
  end
end
