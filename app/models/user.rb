class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self, stretches: 13

  # == Validations =============================================
  validates :email, :encrypted_password, :first_name, :last_name, presence: true

  # == Enums ===================================================
  enum role: {
    admin: 0,
    doctor: 1,
    patient: 2,
  }, _prefix: true

  # == Instance Methods =========================================
  def full_name
    "#{first_name} #{last_name}"
  end
  alias_method :select_label, :full_name
end
