class CoursesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
    authorize! :create, @course
    render :new
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
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :user_id)
  end
end
