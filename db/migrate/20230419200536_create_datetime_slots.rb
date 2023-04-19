class CreateDatetimeSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :datetime_slots do |t|
      t.references :users, foreign_key: :doctor_id, null: false
      t.datetime :slot_datetime, null: false
      t.timestamps
    end

    add_reference :appointments, :datetime_slot, foreign_key: true, null: false
  end
end
