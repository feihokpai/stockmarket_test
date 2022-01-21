Rails.application.routes.draw do
  resources :alerts
  resources :stocks
  resources :wallets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "wallets#index"
end
