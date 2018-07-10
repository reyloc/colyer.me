# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @title = 'Colyer.me'
    @author = 'Jason Colyer'
    @posts = Post.where(public: 1).limit(5).order('updated_at desc')
  end
end
