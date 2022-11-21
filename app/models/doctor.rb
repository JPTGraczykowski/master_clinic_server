class Doctor < User
  default_scope { where(role: :doctor) }

  # == Associations ===========================================
  belongs_to :specialty, required: true
end
