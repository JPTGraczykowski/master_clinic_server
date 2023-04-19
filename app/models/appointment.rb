class Appointment < ApplicationRecord
  # == Associations ==========================================
  belongs_to :specialty, required: true
  belongs_to :patient, required: true
  belongs_to :doctor, required: true
  belongs_to :datetime_slot, required: true
  belongs_to :cabinet

  # == Scopes ================================================
  scope :with_patient_id, ->(patient_id) {
    where(patient_id: patient_id)
  }
  scope :with_doctor_id, ->(doctor_id) {
    where(doctor_id: doctor_id)
  }
  scope :upcoming, ->(_) {
    where("appointment_datetime >= ?", Time.current)
  }
  scope :past, ->(_) {
    where("appointment_datetime < ?", Time.current)
  }

  # == Instance Methods =======================================
  def address
    cabinet&.cabinet_label
  end
end
