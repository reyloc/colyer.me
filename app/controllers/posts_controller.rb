class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:show, :index]
  
  def index
    @posts = Post.all.order(:id)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    redirect_to posts_path unless current_user.author == 1
    @cats = Category.all.order(:name)
  end

  def create
    redirect_to posts_path unless current_user.author == 1
    @post = Post.new(
      :title => params['post']['title'],
      :keywords => params['post']['keywords'],
      :description => params['post']['description'],
      :public => params['post']['public'],
      :user_id => current_user.id
    )
    if @post.save
      params['post']['categories'].each do |cat|
        next if cat.empty?
        PostCategory.new(:category_id => cat, :post_id => @post.id).save
      end
      chunk(params['post']['content']).each do |content|
        PostContent.new(:post_id => @post.id, :content => content).save
      end
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    redirect_to posts_path unless current_user.author == 1
  end

  def destroy
    redirect_to posts_path unless current_user.author == 1
  end


  def chunk(string)
    string.scan(/.{1,250}/)
  end

end
