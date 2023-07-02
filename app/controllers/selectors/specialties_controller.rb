class Selectors::SpecialtiesController < Selectors::SelectorController
  private

  def set_collection
    @collection = Specialty.all.order(:name)
  end
end