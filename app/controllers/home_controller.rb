class HomeController < ApplicationController
  def index
    @title = 'Colyer.me'
    @author = 'Jason Colyer'
    @posts = Post.limit(5).order('updated_at desc')
  end
end
