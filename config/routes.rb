Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'events/new'
  get 'events/show'
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks", confirmations: 'confirmations' }
  root to: 'pages#index'
  get 'pages/index'
  get 'pages/show'
  get '/pages/show_old', to: 'pages#show_old'
  get '/users/search', to: 'users#search'
  post '/users/follow', to:'users#follow'
  resources :events
  resources :posts
  post '/users/approve', to: 'users#approve'
  post '/users/unfollow', to: 'users#unfollow'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
