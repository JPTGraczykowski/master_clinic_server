class Selectors::DatetimeSlotsController < Selectors::SelectorController
  private

  def set_collection
    @collection = DatetimeSlot.available.order(:slot_datetime)
  end

  def set_record
    @record = DatetimeSlot.find(params[:id])
  end
end