class CertificateGenerator
  def initialize(user, course)
    @user = user
    @course = course
  end

  def generate
    Prawn::Document.new do |pdf|
      pdf.text "Certificate of Completion", align: :center, size: 30, style: :bold
      pdf.move_down 50
      pdf.text "This is to certify that", align: :center, size: 20
      pdf.move_down 10
      pdf.text @user.email, align: :center, size: 25, style: :bold

      pdf.move_down 50
      pdf.text "Has successfully completed the course:", align: :center, size: 20
      pdf.move_down 10
      pdf.text @course.title, align: :center, size: 25, style: :bold

      pdf.move_down 50
      pdf.text "Completed on: #{Time.now.strftime('%B %d, %Y')}", align: :center, size: 18

      pdf.move_down 100
      pdf.text "Instructor: #{@course.user.email}", align: :center, size: 18

      pdf.render
    end
  end
end
