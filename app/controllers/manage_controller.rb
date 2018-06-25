class ManageController < ApplicationController
  def users
    @users = User.all.order(:id)
  end

  def categories
    @cats = Category.all.order(:id)
  end

  def posts
    @posts = Post.all.order(:id)
  end
end
