Rails.application.routes.draw do
  resources :labels
  root 'users#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :update]
  resources :tasks
  resources :favorites, only: [:create, :destroy, :index]
  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
