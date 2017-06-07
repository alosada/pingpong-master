Rails.application.routes.draw do
  resources :games
  resources :users, only: [:index]
  devise_for :users
  root to: "home#index"
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'
end
