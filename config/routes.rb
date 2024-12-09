Rails.application.routes.draw do

  root to: "pages#home"

  devise_for :users
  resources :products

  resource :cart, only: :show
  resources :cart_items, only: [:create, :update, :destroy]
  resources :orders, only: [:new, :create, :show]

  get 'promotions', to: 'products#promotions'
  get 'about', to: 'pages#about'
  get 'legales', to: 'pages#legales'



  post 'contact', to: 'pages#contact'
end
