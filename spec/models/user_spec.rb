require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }  # Add this line

    it { should validate_presence_of(:email) }
    # it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    # it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:gsm_ciphertext) }
    it { should validate_uniqueness_of(:gsm_ciphertext) }
    it { should validate_presence_of(:identity_number_ciphertext) }
    it { should validate_uniqueness_of(:identity_number_ciphertext) }
  end

  describe 'associations' do
    it { should have_many(:resumes) }
    it { should have_many(:schools).through(:resumes) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  describe 'custom validations' do
    it 'validates gsm format' do
      user = build(:user, gsm: 'invalid')
      user.valid?
      expect(user.errors[:gsm]).to include('is not a valid phone number')
    end
  end

  describe 'methods' do
    let(:user) { create(:user) }

    it 'returns full name' do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end

    it 'generates a valid JWT token' do
      token = user.generate_jwt
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      expect(decoded_token.first['id']).to eq(user.id)
    end
  end
end