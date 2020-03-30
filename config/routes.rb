Rails.application.routes.draw do
  get 'events/new'
  get 'events/show'
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks"}
  root to: 'pages#index'
  get 'pages/index'
  get 'pages/show'
  get '/pages/show_old', to: 'pages#show_old'
  get '/users/search', to: 'users#search'
  post '/users/follow', to:'users#follow'
  resources :events
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
