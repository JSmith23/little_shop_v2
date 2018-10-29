Rails.application.routes.draw do

  root 'welcome#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/profile', to: 'users#show'
  get '/profile/edit/', to: 'users#edit'
  patch '/profile/edit/', to: 'users#edit'
  get '/profile/orders', to: 'orders#index'


  namespace :dashboard do
    resources :items, only: [:index, :new]
    resources :orders, only: [:index]
  end

  get '/dashboard', to: 'dashboard#show'

  resources :orders, only: [:index, :show, :destroy]

  resources :users, only: [:show, :update, :edit, :index] do
    resources :orders, only: [:index]
  end

  resources :sessions

  resources :items, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  resources :carts, only: [:index, :create]

  resources :users, only: [:index, :show, :destroy] do
    resources :orders, only: [:index]
  end

end
