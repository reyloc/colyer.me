# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :limit_actions, only: %w[:new :edit :update :create :destroy]
  before_action :set_category, except: %w[:index :new :create]

  def index
    @cats = Category.all.order(:name)
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category.id),
                  notice: "Category #{@category.name} has been created!"
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category.id)
    else
      render 'edit'
    end
  end

  def destroy
    PostCategory.where(category_id: @category.id).destroy_all
    @category.destroy
    redirect_to manage_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end

  def set_category
    @category = Category.find(params[:id])
    @keywords = @category.name
    @description = @category.description
  end
end
