class Selectors::CabinetsController < Selectors::SelectorController
  private

  def set_collection
    @collection = Cabinet.all
  end

  def set_record
    @record = Cabinet.find(params[:id])
  end
end