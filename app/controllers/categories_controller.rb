class CategoriesController < ApplicationController
  def index
    @cats = Category.all.order(:name)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    redirect_to categories_path unless current_user.author == 1
    @category = Category.new
  end

  def create
    redirect_to categories_path unless current_user.author == 1
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end

  def update
    redirect_to categories_path unless current_user.author == 1
  end

  def destroy
    redirect_to categories_path unless current_user.author == 1
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end

end
