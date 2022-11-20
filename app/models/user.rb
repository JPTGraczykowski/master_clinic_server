class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, stretches: 13

  # == Validations =============================================
  validates :email, :encrypted_password, :first_name, :last_name, presence: true
end
