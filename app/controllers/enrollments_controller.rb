class EnrollmentsController < ApplicationController 
  def create
    @course = Course.find(params[:course_id])  
    @enrollment = @course.enrollments.new(user_id: current_user.id, is_enrolled: true)  

    if @enrollment.save  
      redirect_to course_lessons_path(@course), notice: 'You have enrolled successfully'  
    else
      render 'courses/show', alert: 'There was an issue with your enrollment'
    end
  end

  def destroy
    @course = Course.find(params[:course_id]) 
    @enrollment = Enrollment.find_by(user_id: current_user.id, course_id: @course.id)
  
    if @enrollment
      @enrollment.destroy
    end
    redirect_to course_path(@course), notice: 'UnEnroll successfully'
  end
end
