class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.references :specialty, foreign_key: true, null: false
      t.references :patient, foreign_key: { to_table: :users }, null: false
      t.references :doctor, foreign_key: { to_table: :users }, null: false
      t.datetime :appointment_datetime, null: false
      t.text :description
      t.references :cabinet, foreign_key: true
      t.text :before_visit
      t.timestamps
    end
  end
end
