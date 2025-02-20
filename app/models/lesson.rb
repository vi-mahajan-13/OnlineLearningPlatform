class Lesson < ApplicationRecord
  belongs_to :course
  has_many :completed_lessons, dependent: :destroy
  has_many :users, through: :completed_lessons
  has_many :pictures, as: :imageable,  dependent: :destroy
  has_one_attached :video

  validates :title, presence: true
  validates :content, presence: true
  
  def next_lesson
    course.lessons.where('created_at > ?', self.created_at).order(:created_at).first
  end

  def previous_lesson
    course.lessons.where('created_at < ?', self.created_at).order(:created_at).last
  end
end
