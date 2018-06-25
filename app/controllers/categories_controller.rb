class CategoriesController < ApplicationController
  before_action :limit_actions, only: [:new, :edit, :update, :create, :destroy]	
  before_action :set_category, except: [:index, :new, :create]

  def index
    @cats = Category.all.order(:name)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category.id), notice: "Category #{@category.name} has been created!"
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
    PostCategory.where(category_id: @category.id).destroy_all
    @category.destroy
    redirect somewhere? 
  end

 private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
