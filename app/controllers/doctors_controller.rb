class DoctorsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :destroy]
  before_action :set_doctor, except: [:create]

  def show
    render_response(@doctor) { true }
  end

  def new
    @doctor = Doctor.new

    render_response(@doctor)
  end

  def create
    @doctor = Doctor.new(create_doctor_attributes)

    render_response(@doctor, status: :created) { @doctor.save }
  end

  def update
    @doctor.assign_attributes(doctor_attributes)

    render_response(@doctor) { @doctor.save }
  end

  def archive
    if @doctor.update(active: false)
      head :ok
    else
      render(json: { message: @doctor.errors.full_messages },
             status: :unprocessable_entity)
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def serialize_record
    DoctorSerializer.new(@doctor).serializable_hash
  end

  def common_params_keys
    [
      :email,
      :first_name,
      :last_name,
      :telephone,
      :specialty_id,
      :cabinet_id,
      :active,
    ]
  end

  def doctor_attributes
    params.require(:doctor).permit(common_params_keys)
  end

  def create_doctor_attributes
    params.require(:doctor).permit(
      *common_params_keys,
      :password
    )
  end
end