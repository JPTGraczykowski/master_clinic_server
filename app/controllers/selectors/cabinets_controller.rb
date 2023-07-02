class Selectors::CabinetsController < Selectors::SelectorController
  private

  def set_collection
    @collection = Cabinet.all
  end
end