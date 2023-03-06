require 'active_record'

module HasFiltersScopes
  module ClassMethods
    def generate_search_for_select_input(*fields)
      fields.each do |field|
        scope :search_for_select_input, ->(param) { where("#{field} ILIKE ?", "%#{param}%") }
      end
    end
  end
end

::ActiveRecord::Base.send(:extend, HasFiltersScopes::ClassMethods)