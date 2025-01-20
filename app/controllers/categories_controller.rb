class CategoriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @courses = @category.courses
  end

  def new
    @category = Category.new
    authorize! :create, @category  # Make sure students can't create categories
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: 'Category was successfully added'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @category
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @category
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed'
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
