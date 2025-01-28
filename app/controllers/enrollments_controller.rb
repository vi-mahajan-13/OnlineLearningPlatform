class EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_enrollment, only: [:destroy, :show]
  load_and_authorize_resource

  def index
    @enrollments = @course.enrollments

    respond_to do |format|
      format.html
      format.csv { send_data @enrollments.to_csv, filename: "enrollments-#{DateTime.now.strftime("%D%M%Y%H%M")}.csv" }
    end
  end
   
  def show
  end

  def create
    @enrollment = @course.enrollments.new(user_id: current_user.id, is_enrolled: true)

    if @enrollment.save
      redirect_to course_lessons_path(@course), notice: 'You have enrolled successfully'
    else
      render 'courses/show', alert: 'There was an issue with your enrollment'
    end
  end

  def destroy
    if @enrollment
      @enrollment.destroy
      redirect_to course_path(@course), notice: 'You have un-enrolled successfully'
    else
      redirect_to course_path(@course), alert: 'Enrollment not found'
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_enrollment
    @enrollment = Enrollment.find_by(user_id: current_user.id, course_id: @course.id)
  end
end
