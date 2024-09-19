class User < ApplicationRecord
  has_secure_password
  has_many :resumes
  has_many :schools, through: :resumes

  validates :email, presence: true, uniqueness: true
  validates :gsm, presence: true, uniqueness: true
  validates :gsm, format: { 
    with: /\A\+?[\d\s\-\(\)]+\z/, 
    message: "should be a valid phone number" 
  }
  # validates :identity_number, presence: true, uniqueness: true

  attr_encrypted :gsm, key: Rails.application.credentials.attr_encrypted_key
  attr_encrypted :identity_number, key: Rails.application.credentials.attr_encrypted_key

  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end

  def gsm=(value)
    write_attribute(:gsm, value.to_s.gsub(/[^\d+]/, ''))
  end

  def gsm
    read_attribute(:gsm)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["first_name", "last_name"]
  end

  private

  def gsm_format
    # This is a basic format check
    unless gsm.match?(/\A\+?[\d\s-]{10,14}\z/)
      errors.add(:gsm, "is not a valid phone number")
    end
  end
end