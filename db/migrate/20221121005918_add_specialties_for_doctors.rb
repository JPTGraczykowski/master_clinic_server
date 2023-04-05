class AddSpecialtiesForDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :specialties do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    add_index :specialties, :name, unique: true

    add_reference :users, :specialty
  end
end
