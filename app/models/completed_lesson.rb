class CompletedLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  after_create :send_course_completed_email

  private

  def send_course_completed_email
    @course = self.lesson.course

    if Course.all_lessons_completed?(@course, self.user)
      SendCertificateJob.set(wait: 2.minutes).perform_later(self.user.id, @course.id)
    end
  end
end
