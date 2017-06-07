Rails.application.routes.draw do
  resources :games, only: [:index, :create]
  resources :users, only: [:index]
  devise_for :users
  root to: "home#index"
  get '/history', to: 'games#index'
  get '/log',     to: 'home#log'
end
