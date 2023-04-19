class DatetimeSlot < ApplicationRecord
  # == Associations ==========================================
  belongs_to :doctor, required: true
  has_one :appointment

  # == Validations ===========================================
  validates_presence_of :slot_datetime

  # == Scopes ================================================
  scope :with_doctor_id, ->(doctor_id) {
    where(doctor_id: doctor_id)
  }
  scope :available, ->(_) {
    includes(:appointment)
      .where
      .not(appointments: { datetime_slot_id: null })
  }
end