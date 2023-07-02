class Doctor < User
  default_scope { where(role: :doctor) }

  # == Associations ===========================================
  belongs_to :specialty, required: true
  belongs_to :cabinet, required: true

  # == Scopes =================================================
  scope :with_specialty, ->(specialty_id) {
    where(specialty_id: specialty_id)
  }
end
