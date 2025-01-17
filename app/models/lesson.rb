class Lesson < ApplicationRecord
  belongs_to :course
  has_many :completed_lessons, dependent: :destroy
  has_many :users, through: :completed_lessons

  def next_lesson
    course.lessons.where('created_at > ?', self.created_at).order(:created_at).first
  end

  def previous_lesson
    course.lessons.where('created_at < ?', self.created_at).order(:created_at).last
  end
end
