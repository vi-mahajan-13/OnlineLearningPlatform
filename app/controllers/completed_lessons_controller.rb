class CompletedLessonsController < ApplicationController
  def create
    
    @lesson = Lesson.find(params[:lesson_id])  
    @completed_lesson = @lesson.completed_lessons.new(user_id: current_user.id, completed: true)  
    @course = Course.find(params[:course_id])
    if @completed_lesson.save  
      redirect_to course_lesson_path(@course, @lesson), notice: 'You have completed this lesson'  
    else
      render 'lessons/show', alert: 'There was an issue with your completion'
    end
  end

  def destroy
    @lesson = Lesson.find(params[:lesson_id]) 
    @course = Course.find(params[:course_id])
    @completed_lesson = CompletedLesson.find_by(user_id: current_user.id, lesson_id: @lesson.id)
  
    if @completed_lesson
      @completed_lesson.destroy
    end
    redirect_to course_lesson_path(@course, @lesson), notice: 'this lesson is incomplete'
  end
end
