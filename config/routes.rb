Rails.application.routes.draw do
  devise_for :users
  root to: "tasks#index"
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update]
end
