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
    redirect_to categories_path unless current_user.admin == 1
    @cat = Category.find(params[:id])
    purge_category(@cat)
    if current_user.admin == 1
      redirect_to manage_categories_path
    else
      redirect_to categories_path
    end
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end

  private

  def cat_has_posts?(id)
    if Category.find(id).posts.count.zero?
     false
    else
      true
    end
  end

  def purge_category(c)
    if cat_has_posts?(c.id)
      c.posts.each do |p|
        PostCategory.where(:category_id => c.id, :post_id => p.id).each do |pc|
          pc.destroy
        end
      end
    end
    c.destroy
  end

end
