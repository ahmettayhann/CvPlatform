class User < ApplicationRecord
  has_secure_password
  has_many :resumes
  has_many :schools, through: :resumes
  has_one_attached :avatar

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :country, presence: true
  validates :gsm_ciphertext, presence: true, uniqueness: true
  validates :identity_number_ciphertext, presence: true, uniqueness: true

  # Custom validations
  validate :gsm_format

  # Custom methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def self.ransackable_attributes(auth_object = nil)
    ["first_name", "last_name", "email"]
  end

  # Encryption methods
  def gsm
    decrypt(gsm_ciphertext) if gsm_ciphertext.present?
  end

  def gsm=(value)
    self.gsm_ciphertext = encrypt(value) if value.present?
  end

  def identity_number
    decrypt(identity_number_ciphertext) if identity_number_ciphertext.present?
  end

  def identity_number=(value)
    self.identity_number_ciphertext = encrypt(value) if value.present?
  end

  private

  def gsm_format
    return if gsm.blank?
    unless gsm.match?(/\A\+?[\d\s-]{10,14}\z/)
      errors.add(:gsm, "is not a valid phone number")
    end
  end

  def encrypt(value)
    Rails.application.message_verifier(:user_data).generate(value)
  end

  def decrypt(value)
    Rails.application.message_verifier(:user_data).verify(value)
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end
end