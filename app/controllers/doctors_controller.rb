class DoctorsController < ApplicationController
  before_action :authenticate_admin!, only: [:create, :destroy]
  before_action :set_doctor, except: [:create]

  def show
    render(json: serialize_doctor, status: :ok)
  end

  def create
    @doctor = Doctor.new(create_doctor_attributes)

    if @doctor.save
      render(json: serialize_doctor, status: :ok)
    else
      render(json: { message: @doctor.errors.full_messages },
             status: :unprocessable_entity)
    end
  end

  def update
    @doctor.assign_attributes(doctor_attributes)

    if @doctor.save
      render(json: serialize_doctor, status: :ok)
    else
      render(json: { message: @doctor.errors.full_messages },
             status: :unprocessable_entity)
    end
  end

  def destroy
    if @doctor.destroy
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

  def serialize_doctor
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