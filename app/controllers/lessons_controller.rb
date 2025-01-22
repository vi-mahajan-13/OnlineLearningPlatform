class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_lesson, only: [:show, :edit, :update]
  load_and_authorize_resource :course
  load_and_authorize_resource :lesson, through: :course

  def index
    @lessons = @course.lessons
  end   

  def show
    @next_lesson = @lesson.next_lesson 
    @previous_lesson = @lesson.previous_lesson
  end

  def new
    @lesson = @course.lessons.new
    authorize! :create, @lesson
  end

  def create
    @lesson = @course.lessons.new(lesson_params)
    
    if @lesson.save
      redirect_to course_lessons_path(@course), notice: 'Lesson successfully created.'
    else
      render :new
    end
  end
  


  def edit
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to course_lessons_path(@course), notice: 'Lesson successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lesson.destroy
    redirect_to course_lessons_path(course_id: @lesson.course.id), notice: 'Lesson was successfully deleted.'
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :content, pictures: [])
  end
end
