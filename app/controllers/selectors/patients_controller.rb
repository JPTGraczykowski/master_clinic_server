class Selectors::PatientsController < Selectors::SelectorController
  private

  def set_collection
    @collection = Patient.all.order(:last_name)
  end
end