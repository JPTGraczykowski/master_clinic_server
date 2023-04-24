class AddDefaultBeforeVisitToSpecialties < ActiveRecord::Migration[6.1]
  def change
    add_column :specialties, :default_before_visit, :text
  end
end
