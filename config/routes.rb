Rails.application.routes.draw do
  get 'manage/users'
  get 'manage/categories'
  get 'manage/posts'
  get 'api/edit_user'
  get 'api/kill_user'
  get 'api/edit_category'
  get 'api/kill_category'
  get 'api/toggle_post_public'
  resources :posts
  resources :categories
  devise_for :users
  resources :home, only: [:index]
  post 'update_picture/update'
  root to: 'home#index'
end
