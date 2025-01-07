class LessonsController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @lessons = @course.lessons.all
  end

   
  def show
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
  end

  def new
    @course = Course.find(params[:course_id])   
    @lesson = @course.lessons.new    
  end

  def create
    @course = Course.find(params[:course_id])       
    @lesson = @course.lessons.new(lesson_params)       
    
    if @lesson.save
      redirect_to course_lessons_path(@course), notice: 'Lesson successfully created.'
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
  end

  def update
    @course = Course.find(params[:course_id])
    @lesson = @course.lessons.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to course_lessons_path(@course), notice: 'Lesson successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  private

  def lesson_params
    params.require(:lesson).permit(:title, :content)
  end

end
