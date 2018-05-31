Rails.application.routes.draw do
  get 'manage/users'
  get 'manage/categories'
  get 'manage/posts'
  resources :posts
  resources :categories
  devise_for :users
  get 'home/index'
  post 'update_picture/update'
  root 'home#index'
end
