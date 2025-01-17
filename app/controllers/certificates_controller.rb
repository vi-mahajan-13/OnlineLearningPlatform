class CertificatesController < ApplicationController
  before_action :authenticate_user!

  def show
    @course = Course.find(params[:id])

    @completed_lessons_count = 0
    @total_lessons_count = @course.lessons.count

    @course.lessons.each do |lesson|
      if CompletedLesson.exists?(user_id: current_user.id, lesson_id: lesson.id, completed: true)
        @completed_lessons_count += 1
      end
    end

    if @completed_lessons_count == @total_lessons_count
      @certificate_generator = CertificateGenerator.new(current_user, @course)
      pdf_data = @certificate_generator.generate
      send_data pdf_data.render, 
                filename: "certificate_#{current_user.email}_#{@course.title}.pdf", 
                type: "application/pdf", 
                disposition: "inline"  
    else
      redirect_to @course, alert: "You need to complete all lessons in this course to generate the certificate."
    end
  end
end
