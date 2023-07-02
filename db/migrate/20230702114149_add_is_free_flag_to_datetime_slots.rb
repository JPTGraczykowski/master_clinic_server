class AddIsFreeFlagToDatetimeSlots < ActiveRecord::Migration[6.1]
  def change
    add_column :datetime_slots, :is_free, :boolean, default: true
    migrate_existing_datetime_slots
  end

  def migrate_existing_datetime_slots
    DatetimeSlot
      .joins(:appointment)
      .where.not(appointments: { datetime_slot_id: nil })
      .update_all(is_free: false)
  end
end
