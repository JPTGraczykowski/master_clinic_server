class Selectors::CabinetsController < Selectors::SelectorController
  private

  def set_collection
    @collection = Cabinet.all
    @collection = @collection.with_doctor_id(params[:doctor_id]) if params[:doctor_id].present?
  end
end