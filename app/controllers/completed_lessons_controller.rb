class CompletedLessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson_and_course
  before_action :set_completed_lesson, only: [:destroy]
  load_and_authorize_resource

  def create
    @completed_lesson = @lesson.completed_lessons.new(user_id: current_user.id, completed: true)

    if @completed_lesson.save
      redirect_to course_lesson_path(@course, @lesson), notice: 'You have completed this lesson'
    else
      render 'lessons/show', alert: 'There was an issue with your completion'
    end
  end
  
  def destroy
    if @completed_lesson
      @completed_lesson.destroy
      redirect_to course_lesson_path(@course, @lesson), notice: 'This lesson is incomplete'
    else
      redirect_to course_lesson_path(@course, @lesson), alert: 'You cannot do this'
    end
  end

  private

  def set_lesson_and_course
    @lesson = Lesson.find(params[:lesson_id])
    @course = Course.find(params[:course_id])
  end

  def set_completed_lesson
    @completed_lesson = CompletedLesson.find_by(user_id: current_user.id, lesson_id: @lesson.id)
  end
end
