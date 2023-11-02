class Selectors::DoctorsController < Selectors::SelectorController
  private

  def set_collection
    @collection = Doctor.all.order(:last_name)
    @collection = @collection.with_specialty(params[:specialty_id]) if params[:specialty_id].present?
  end
end