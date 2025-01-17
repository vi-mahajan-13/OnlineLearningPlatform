class Course < ApplicationRecord
  include Searchable
  
  belongs_to :user
  belongs_to :category
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_students, through: :enrollments, source: :user
end
