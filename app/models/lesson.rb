class Lesson < ApplicationRecord
  belongs_to :course
  has_many :completed_lessons
  has_many :users, through: :completed_lessons
end

