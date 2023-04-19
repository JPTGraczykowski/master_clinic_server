class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.references :specialties, foreign_key: true, null: false
      t.references :users, foreign_key: :patient_id, null: false
      t.references :users, foreign_key: :doctor_id, null: false
      # t.references :datetime_slots, foreign_key: true, null: false
      t.datetime :appointment_datetime, null: false
      t.text :description
      t.references :cabinets, foreign_key: true
      t.text :before_visit
      t.timestamps
    end
  end
end
