class Patient < User
  default_scope { where(role: :patient) }
end
