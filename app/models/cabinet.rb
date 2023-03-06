class Cabinet < ApplicationRecord
  has_many :doctors

  # == Scopes ================================================
  generate_search_for_select_input :name, :floor
end