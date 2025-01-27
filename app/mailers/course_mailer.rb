class CourseMailer < ApplicationMailer
  def course_completed_email(user, course)
    @user = user
    @course = course
    @certificate_generator = CertificateGenerator.new(@user, @course)
    pdf_data = @certificate_generator.generate

    attachments["certificate_#{@user.email}_#{@course.title}.pdf"] = pdf_data.render
    mail(
      to: @user.email,
      subject: "Congratulations! You have completed the #{@course.title} course"
    )
  end
end
