# frozen_string_literal: true

class ApiController < ApplicationController
  before_action :set_user, only: %w[:edit_user :kill_user]
  before_action :set_post, only: :toggle_post_public

  def edit_user
    response = false
    if valid_edit_user?
      make_changes
      response = true
      cause = ''
    else
      cause = cause_of_bad_edit_user
    end
    render json: { 'response': response, 'reason': cause }
  end

  def kill_user
    if @user.id == current_user.id
      response = false
      cause = 'You cannot delete yourself in this way'
    else
      purge_user
      response = true
      cause = ''
    end
    render json: { 'response': response, 'reason': cause }
  end

  def toggle_post_public
    change_post_public
    render json: { 'response': true, 'reason': '' }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def purge_user
    if user_has_posts? @user.id
      @user.posts.each do |p|
        p.post_contents.destroy_all
        p.destroy
      end
    end
    @user.destroy
  end

  def change_post_public
    @post.public = (@post.public.zero? ? 1 : 0)
    @post.save
  end

  def valid_edit_user?
    false if author_has_posts?
    false if current_user_is_admin?
    false if no_change?
    true
  end

  def cause_of_bad_edit_user
    return 'User has existing posts assigned to them' if author_has_posts?
    return 'You can not demote yourself from admin' if current_user_is_admin?
    return "You didn't change anything" if no_change?
    'Unknown'
  end

  def author_has_posts?
    params[:author] == '0' && user_has_posts?(@user.id)
  end

  def current_user_is_admin?
    params[:admin] == '0' && @user.id == current_user.id
  end

  def no_change?
    params[:admin].to_i == @user.admin && params[:author].to_i == @user.author
  end

  def make_changes
    @user.admin = params[:admin].to_i
    @user.author = params[:author].to_i
    @user.save
  end
end
