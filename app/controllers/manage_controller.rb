# frozen_string_literal: true

class ManageController < ApplicationController
  before_action :authenticate_user!
  before_action :limit_actions

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
