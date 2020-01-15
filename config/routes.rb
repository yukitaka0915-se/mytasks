Rails.application.routes.draw do
  devise_for :users
  root to: "groups#index"
  resources :users, only: [:index, :edit, :update] do
    resources :groups, only: [:new, :create, :edit, :update, :destroy]
  end
end
