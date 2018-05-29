Rails.application.routes.draw do
  resources :posts
  devise_for :users
  get 'home/index'
  post 'update_picture/update'
  root 'home#index'
end
