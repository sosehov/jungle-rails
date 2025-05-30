class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  def self.authenticate_with_credentials(email, password)
    normalized_email = email.strip.downcase
    user = User.find_by('LOWER(email) = ?', normalized_email)
    user&.authenticate(password) ? user : nil
  end
end
