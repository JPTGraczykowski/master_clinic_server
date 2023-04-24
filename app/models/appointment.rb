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
  scope :upcoming, -> {
    where("appointment_datetime >= ?", Time.current)
  }
  scope :past, -> {
    where("appointment_datetime < ?", Time.current)
  }

  # == Callbacks =============================================
  before_validation :assign_cabinet,
                    :assign_appointment_datetime,
                    :assign_default_before_visit

  # == Instance Methods ======================================
  def address
    cabinet&.cabinet_label
  end

  def assign_appointment_datetime
    self.appointment_datetime ||= datetime_slot&.slot_datetime
  end

  def assign_cabinet
    self.cabinet ||= doctor&.cabinet
  end

  def assign_default_before_visit
    self.before_visit ||= specialty.default_before_visit
  end
end
