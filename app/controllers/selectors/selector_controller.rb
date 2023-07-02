class Selectors::SelectorController < ApplicationController
  before_action :set_collection, only: :index
  before_action :set_record, only: :show

  def index
    @collection = @collection.search_for_select_input(params[:search]) if params[:search].present?

    render(json: serialize_collection(@collection), status: :ok)
  end

  protected

  def set_collection
    raise "#{controller_name} controller should implement set_collection method"
  end

  def serialize_collection(items)
    items.map do |item|
      {
        id: item.id,
        text: item.select_label,
      }
    end
  end
end