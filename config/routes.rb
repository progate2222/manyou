Rails.application.routes.draw do
  get 'sessions/new'
  root 'users#new'
  resources :users, only: [:new, :create, :show]
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
