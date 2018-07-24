Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  ##front
  #root
  root "posts#index"
  #user
  resources :users, only: [:show, :edit, :update] do
    member do
      get :post
      get :collect
      get :comment
      get :draft
      get :friend
    end
  end
  #posts
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  get "/feeds", to: "feeds#index"
  ##back
  #admin
  namespace :admin do
    resources :posts, only: [:index, :destroy]
    resources :users, only: [:index, :update]
    resources :categories
  end
end
