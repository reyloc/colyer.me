class PostsController < ApplicationController
  before_action :authenticate_user!, except: %w[:show :index]
  before_action :limit_actions, only: %w[:new :edit :update :create :destroy]
  before_action :set_post, except: %w[:index :new :create]
  before_action :redirect_if_not_public,
                except: %w[:index :new :create :destroy]

  def index
    @posts = Post.where(public: 1).order(:id)
  end

  def show; end

  def new
    redirect_to posts_path unless current_user.author == 1
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render 'edit'
    end
  end

  def destroy
    PostCategory.where(post_id: @post.id).destroy_all
    @post.destroy
    redirect_to manage_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :keywords, :description,
                                 :public, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
    @title = @post.title
    @author = @post.user.full_name
    @keywords = "#{@post.keywords},#{@post.categories.pluck(:name).join(',')}"
    @description = @post.description
  end

  def redirect_if_not_public
    return unless @post.public.zero?
    redirect_to posts_path unless @post.user_id == current_user.id
  end
end
