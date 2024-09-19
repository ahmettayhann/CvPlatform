class Resume < ApplicationRecord
  belongs_to :user
  has_many :resume_schools
  has_many :schools, through: :resume_schools
  
  has_rich_text :description
  has_one_attached :file

  validates :title, presence: true
  validate :acceptable_file

  accepts_nested_attributes_for :resume_schools, allow_destroy: true, reject_if: :all_blank
  
  scope :active, -> { where(active: true) }

  def self.ransackable_attributes(auth_object = nil)
    ["title", "created_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  private

  def acceptable_file
    return unless file.attached?

    unless file.blob.byte_size <= 5.megabyte
      errors.add(:file, "is too big (should be at most 5MB)")
    end

    acceptable_types = ["application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]
    unless acceptable_types.include?(file.content_type)
      errors.add(:file, "must be a PDF or a Word document")
    end
  end
end