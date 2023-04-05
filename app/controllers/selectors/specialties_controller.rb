class Selectors::SpecialtiesController < Selectors::SelectorController
  private

  def set_collection
    @collection = Specialty.all
  end

  def set_record
    @record = Specialty.find(params[:id])
  end
end