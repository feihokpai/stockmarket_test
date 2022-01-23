Rails.application.routes.draw do
  resources :alerts_histories
  devise_for :users
  resources :alerts
  resources :stocks do
    get 'update_price', to: "stocks#update_price_with_api"
  end
  resources :wallets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "wallets#index"
end
