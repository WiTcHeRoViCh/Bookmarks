Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions, only: [:new, :create, :destroy]
  resources :bookmarks, only: [:index, :create, :destroy]
  resources :friendships, only: :show

  root 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'friends', to: 'friendships#index'

  get '/auth/:provider/callback', to: 'sessions#create'
end
