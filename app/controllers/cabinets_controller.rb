class CabinetsController < ApplicationController
  before_action :authenticate_not_patient!
  before_action :set_cabinet, only: [:show, :update, :destroy]

  def index
    @cabinets = Cabinet.with_doctor_id(current_user.id)
    @cabinets = @cabinets.order(:slot_datetime)

    render_response(@cabinets) { true }
  end

  def show
    render_response(@cabinet) { true }
  end

  def create
    @cabinet = Cabinet.new(cabinet_params)

    render_response(@cabinet, status: :created) { @cabinet.save }
  end

  def update
    @cabinet.assign_attributes(cabinet_params)

    render_response(@cabinet) { @cabinet.save }
  end

  def destroy
    proceed_deletion(@cabinet)
  end

  private

  def set_datetime_slot
    @cabinet = Cabinet
                 .with_doctor_id(current_user.id)
                 .find(params[:id])
  end

  def serialize_record(record)
    CabinetSerializer.new(record).serializable_hash
  end

  def datetime_slot_params
    params.require(:cabinet).permit(
      :cabinet_id,
    )
  end
end