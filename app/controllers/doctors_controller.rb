class DoctorsController < ApplicationController
  before_action :authenticate_admin!, only: [:create, :destroy]
  before_action :set_doctor, except: [:create]

  def show
    render(json: serialize_doctor, status: :ok)
  end

  def create
    @doctor = Doctor.new(doctor_attributes)

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

  def doctor_attributes
    params.require(:doctor).permit(
      :email,
      :first_name,
      :last_name,
      :telephone,
      :specialty_id,
      :cabinet_id,
      :active
    )
  end
end