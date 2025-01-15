class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update]
  load_and_authorize_resource

  def index
    @clicked_my_learning = params[:clicked_my_learning]
    @clicked_my_courses = params[:clicked_my_courses]
    
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @courses = @category.courses
    elsif current_user.student?
      @courses = @clicked_my_learning ? current_user.enrolled_courses : Course.all
    elsif current_user.instructor?
      @courses = @clicked_my_courses ? current_user.courses : Course.all
    elsif current_user.admin?
      if @clicked_my_courses
        @courses = current_user.courses
      elsif @clicked_my_learning
        @courses = current_user.enrolled_courses
      else
        @courses = Course.all
      end
    end
  end

  def show
    
  end

  def new
    @course = Course.new
    authorize! :create, @course
  end

  def create
    @course = Course.new(course_params)
   
    if @course.save!
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end
  
  def update
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :user_id, :category_id)
  end
end
