class ApiController < ApplicationController

  def edit_user
    user = User.find(params[:id])
    if params[:author] == '0' && user_has_posts?(user.id)
      response = false
      cause = "User has existing posts assigned to them"
    elsif params[:admin] == '0' && user.id == current_user.id
      response = false
      cause = "You can not demote yourself from admin"
    elsif params[:admin].to_i == user.admin && params[:author].to_i == user.author
      response = false
      cause = "You didn't change anything"
    else
      user.admin = params[:admin].to_i
      user.author = params[:author].to_i
      user.save
      response = true
      cause = ""
    end
    render json: {"response": response, "reason": cause}
  end

  def kill_user
    user = User.find(params[:id])
    if user.id == current_user.id
      response = false
      cause = 'You cannot delete yourself in this way'
    else
      purge_user(user)
      response = true
      cause = ''
    end
    render json: {"response": response, "reason": cause}
  end

  def toggle_post_public
    post = Post.find(params[:id])
    change_post_public(post)
    render json: {"response": true, "reason": ""}
  end

  private

  def purge_user(u)
    if user_has_posts? u.id
      u.posts.each do |p|
        p.post_contents.destroy_all
        p.destroy
      end
    end
    u.destroy
  end
  def change_post_public(p)
    if p.public.zero?
      p.public = 1
    else
      p.public = 0
    end
    p.save
  end
end
