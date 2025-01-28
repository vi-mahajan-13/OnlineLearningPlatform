class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @clicked_my_learning = params[:clicked_my_learning]
    @clicked_my_courses = params[:clicked_my_courses]
    @courses = Course.filtered_courses(current_user, @clicked_my_learning, @clicked_my_courses, params[:category_id], params[:q])
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
      if params[:course][:picture].present?
        @course.create_picture(image: params[:course][:picture])
      end
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      if params[:course][:picture].present?
        @course.create_picture(image: params[:course][:picture])
      end
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: 'Course and its lessons and enrollments were successfully deleted.'
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :user_id, :category_id)
  end
end
