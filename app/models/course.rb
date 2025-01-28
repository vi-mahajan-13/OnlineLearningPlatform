class Course < ApplicationRecord
  include Searchable

  belongs_to :user
  belongs_to :category
  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_students, through: :enrollments, source: :user
  has_one :picture, as: :imageable, dependent: :destroy
  
  validates :title, presence: true
  validates :description, presence: true
  validates :category, presence: true

  def self.filtered_courses(current_user, clicked_my_learning, clicked_my_courses, category_id, query)
    if category_id
      category_courses(category_id, query)
    elsif current_user.student?
      student_courses(current_user, clicked_my_learning, query)
    elsif current_user.instructor? || current_user.admin?
      instructor_or_admin_courses(current_user, clicked_my_learning, clicked_my_courses, query)
    else
      Course.all
    end
  end

  def self.all_lessons_completed?(course, user)
    course.lessons.each do |lesson|
      unless CompletedLesson.exists?(user_id: user.id, lesson_id: lesson.id, completed: true)
        return false
      end
    end
    true
  end

  private

  def self.category_courses(category_id, query)
    category = Category.find(category_id)
    query.present? ? category.courses.search(query) : category.courses
  end

  def self.student_courses(current_user, clicked_my_learning, query)
    if clicked_my_learning
      query.present? ? current_user.enrolled_courses.search(query) : current_user.enrolled_courses
    else
      query.present? ? Course.search(query) : Course.all
    end
  end

  def self.instructor_or_admin_courses(current_user, clicked_my_learning, clicked_my_courses, query)
    if clicked_my_courses
      query.present? ? current_user.courses.search(query) : current_user.courses
    elsif clicked_my_learning
      query.present? ? current_user.enrolled_courses.search(query) : current_user.enrolled_courses
    else
      query.present? ? Course.search(query) : Course.all
    end
  end
  
  def self.generate_and_send_certificate(course, user)
    certificate_generator = CertificateGenerator.new(user, course)
    pdf_data = certificate_generator.generate

    send_data pdf_data.render, 
              filename: "certificate_#{user.email}_#{course.title}.pdf", 
              type: "application/pdf", 
              disposition: "inline"
  end
end
