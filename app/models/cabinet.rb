class Cabinet < ApplicationRecord
  has_many :doctors

  # == Scopes ================================================
  scope :search_for_select_input, ->(param) {
    where("name ILIKE ?", "%#{param}%")
  }

  # == Instance Methods ======================================
  def cabinet_label
    "#{name}, Floor: #{floor}"
  end
  alias_method :select_label, :cabinet_label
end