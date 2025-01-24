class CourseMailer < ApplicationMailer
  def course_completed_email(user, course)
    @user = user
    @course = course
    mail(
      to: @user.email,
      subject: "Congratulations! You have completed the #{@course.title} course"
    )
  end
end
