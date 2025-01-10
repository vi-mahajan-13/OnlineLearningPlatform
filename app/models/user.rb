class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   enum role: { student: 'student', instructor: 'instructor', admin: 'admin' }
   

  has_many :courses, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :completed_lessons, dependent: :destroy
  has_many :lessons, through: :completed_lessons

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :student  
  end
end
