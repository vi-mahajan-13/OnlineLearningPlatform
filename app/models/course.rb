class Course < ApplicationRecord
  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :enrollments
  has_many :enrolled_students, through: :enrollments, source: :user
end
