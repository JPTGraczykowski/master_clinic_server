class Cabinet < ApplicationRecord
  has_many :doctors

  # == Scopes ================================================
  scope :search_for_select_input, ->(param) {
    where("name ILIKE ?", "%#{param}%")
  }

  # == Instance Methods ======================================
  def select_label
    "#{name}, Floor: #{floor}"
  end
end