class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update]
  load_and_authorize_resource

  def index
    @clicked_my_learning = params[:clicked_my_learning]
    @clicked_my_courses = params[:clicked_my_courses]
    @courses = filtered_courses
  end

  def show
  end

  def new
    @course = Course.new
    authorize! :create, @course
  end

  def create
    @course = Course.new(course_params)
    if @course.save
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

  def filtered_courses
    if params[:category_id]
      category_courses
    elsif current_user.student?
      student_courses
    elsif current_user.instructor? || current_user.admin?
      instructor_or_admin_courses
    else
      Course.all
    end
  end

  def category_courses
    category = Category.find(params[:category_id])
    params[:q].present? ? category.courses.search(params[:q]) : category.courses
  end

  def student_courses
    if @clicked_my_learning
      params[:q].present? ? current_user.enrolled_courses.search(params[:q]) : current_user.enrolled_courses
    else
      params[:q].present? ? Course.search(params[:q]) : Course.all
    end
  end

  def instructor_or_admin_courses
    if @clicked_my_courses
      params[:q].present? ? current_user.courses.search(params[:q]) : current_user.courses
    elsif @clicked_my_learning
      params[:q].present? ? current_user.enrolled_courses.search(params[:q]) : current_user.enrolled_courses
    else
      params[:q].present? ? Course.search(params[:q]) : Course.all
    end
  end
end
