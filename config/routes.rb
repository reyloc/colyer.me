Rails.application.routes.draw do
  devise_for :users
  get 'manage/users'
  get 'manage/categories'
  get 'manage/posts'
  get 'api/edit_user'
  get 'api/kill_user'
  get 'api/toggle_post_public'
  resources :posts
  resources :categories
  resources :comments, except: [:index, :show]
  resources :resume, only: [:index]
  get 'resume/download'
  resources :home, only: [:index]
  post 'update_picture/update'
  root to: 'home#index'
end
