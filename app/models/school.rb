class School < ApplicationRecord
	has_many :resume_schools
	has_many :resumes, through: :resume_schools

	validates :name, presence: true
end