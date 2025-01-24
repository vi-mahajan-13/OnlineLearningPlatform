class SendCertificateJob < ApplicationJob
  queue_as :default

  def perform(user_id, course_id)  
    user = User.find(user_id)  
    course = Course.find(course_id)  

    CourseMailer.course_completed_email(user, course).deliver_later
  end
end
