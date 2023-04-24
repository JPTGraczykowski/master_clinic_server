class DatetimeSlotsController < ApplicationController
  before_action :authenticate_not_patient!
  before_action :set_datetime_slot, only: [:show, :update, :destroy]

  def index
    @datetime_slots = DatetimeSlot.with_doctor_id(current_user.id)
    @datetime_slots = @datetime_slots.order(:slot_datetime)

    render_response(@datetime_slots) { true }
  end

  def show
    render_response(@datetime_slot) { true }
  end

  def create
    @datetime_slot = DatetimeSlot.new(datetime_slot_params)

    render_response(@datetime_slot, status: :created) { @datetime_slot.save }
  end

  def update
    @datetime_slot.assign_attributes(datetime_slot_params)

    render_response(@datetime_slot) { @datetime_slot.save }
  end

  def destroy
    proceed_deletion(@datetime_slot)
  end

  private

  def set_datetime_slot
    @datetime_slot = DatetimeSlot
                       .with_doctor_id(current_user.id)
                       .find(params[:id])
  end

  def serialize_record(record)
    DatetimeSlotSerializer.new(record).serializable_hash
  end

  def datetime_slot_params
    params.require(:datetime_slot).permit(
      :doctor_id,
      :slot_datetime
    )
  end
end