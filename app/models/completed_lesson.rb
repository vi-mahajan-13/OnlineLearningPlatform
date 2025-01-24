class CompletedLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  after_create :send_course_completed_email

  private

  def send_course_completed_email
    @course = self.lesson.course
    @completed_lessons_count = 0
    @total_lessons_count = @course.lessons.count

    @course.lessons.each do |lesson|
      if CompletedLesson.exists?(user_id: self.user.id, lesson_id: lesson.id, completed: true)
        @completed_lessons_count += 1
      end
    end

    if @completed_lessons_count == @total_lessons_count
      SendCertificateJob.set(wait: 2.minutes).perform_later(self.user.id, @course.id)  # Pass IDs, not objects
    end
  end
end
