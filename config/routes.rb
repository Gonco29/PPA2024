Rails.application.routes.draw do

  root to: "pages#home"

  devise_for :users
  resources :products

  resource :cart, only: :show
  resources :cart_items, only: [:create, :update, :destroy]
  resources :orders, only: [:new, :create, :show]
end
