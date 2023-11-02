class Selectors::DatetimeSlotsController < Selectors::SelectorController
  private

  def set_collection
    @collection = DatetimeSlot.available.order(:slot_datetime)
    @collection = @collection.with_doctor_id(params[:doctor_id]) if params[:doctor_id].present?
  end
end