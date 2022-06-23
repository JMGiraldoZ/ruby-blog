Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  
  resources :users, only: [:edit, :show, :destroy, :index, :update] do
    member do
      get :following, :followers
    end
  end
  resources :articles do
    resources :comments
  end
  resources :relationships, only: [:create, :destroy]
end
