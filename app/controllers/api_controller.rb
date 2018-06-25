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
  def edit_category
    cat = Category.find(params[:id])
    if cat.name == params[:name] && cat.description == params[:desc]
      response = false
      cause = "You didn't make any changes"
    elsif params[:name].empty?
      response = false
      cause = "You can't have a blank category name"
    elsif params[:desc].empty?
      response = false
      cause = "You can't have a blank category description"
    elsif Category.where(:name => params[:name]).present?
      response = false
      cause = 'A category already exists with that name'
    else
      cat.name = params[:name]
      cat.description = params[:desc]
      cat.save
      response = true
      cause = ""
    end
    render json: {"response": response, "reason": cause}
  end
  def kill_category
    cat = Category.find(params[:id])
    purge_category(cat)
    render json: {"response": true, "reason": ""}
  end

  def toggle_post_public
    post = Post.find(params[:id])
    change_post_public(post)
    render json: {"response": true, "reason": ""}
  end

  private

  def user_has_posts?(id)
    if User.find(id).posts.count.zero?
      false
    else
      true
    end
  end
  def cat_has_posts?(id)
    if Category.find(id).posts.count.zero?
     false
    else
      true
    end
  end
  def purge_user(u)
    if user_has_posts? u.id
      u.posts.each do |p|
        p.post_contents.each do |pc|
          pc.destroy
        end
        p.destroy
      end
    end
    u.destroy
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
  def change_post_public(p)
    if p.public.zero?
      p.public = 1
    else
      p.public = 0
    end
    p.save
  end
end
