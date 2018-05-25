class CategoriesController < ApplicationController
  def index
    @cats = Category.all.order(:name)
  end

  def show
    @posts = Post.where("#{params[:id]} = ANY(categories)").order(:name)
  end

end
