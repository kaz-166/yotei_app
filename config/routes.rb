Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks", confirmations: 'confirmations' }
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    get 'events/new'
    get 'events/show'
    root to: 'pages#index'
    get 'pages/index'
    get 'pages/show'
    get '/pages/show_old', to: 'pages#show_old'
    get '/users/search', to: 'users#search'
    get '/users/lang', to: 'users#lang'
    post '/users/follow', to:'users#follow'
    resources :events
    resources :posts
    post '/users/approve', to: 'users#approve'
    post '/users/unfollow', to: 'users#unfollow'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
