require 'rails_helper'

RSpec.describe Resume, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:resume)).to be_valid
    end
  end

  describe 'scopes' do
    it 'returns only active resumes' do
      active_resume = create(:resume, active: true)
      inactive_resume = create(:resume, active: false)
      expect(Resume.where(active: true)).to include(active_resume)
      expect(Resume.where(active: true)).not_to include(inactive_resume)
    end
  end
end