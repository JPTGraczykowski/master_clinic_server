class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :update, :delete]

  def show
    render_response(@patient) { true }
  end

  def new
    @patient = Patient.new

    render_response(@patient) { true }
  end

  def create
    @patient = Patient.new(create_patient_params)

    render_response(@patient, status: :created) { @patient.save }
  end

  def update
    @patient.assign_attributes(patient_params)

    render_response(@patient) { @patient.save }
  end

  def archive
    if @patient.update(active: false)
      head :ok
    else
      render(json: { message: @patient.errors.full_messages },
             status: :unprocessable_entity)
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def serialize_record
    PatientSerializer.new(@patient).serialized_json
  end

  def common_params_keys
    [
      :email,
      :first_name,
      :last_name,
      :telephone
    ]
  end

  def patient_params
    params.require(:patient).permit(common_params_keys)
  end

  def create_patient_params
    params.require(:patient).permit(
      *common_params_keys,
      :password
    )
  end
end