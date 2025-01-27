class CertificatesController < ApplicationController
  before_action :authenticate_user!

  def show
    @course = Course.find(params[:id])

    if Course.all_lessons_completed?(@course, current_user)
      generate_and_send_certificate
    else
      redirect_to @course, alert: "You need to complete all lessons in this course to generate the certificate."
    end
  end

  private

  def generate_and_send_certificate
    @certificate_generator = CertificateGenerator.new(current_user, @course)
    pdf_data = @certificate_generator.generate

    send_data pdf_data.render, 
              filename: "certificate_#{current_user.email}_#{@course.title}.pdf", 
              type: "application/pdf", 
              disposition: "inline"
  end
end
