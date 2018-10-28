Rails.application.routes.draw do

  root "welcome#index"
  
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  get 'profile', to: 'users#show'

  get 'profile/edit', to: 'users#edit'
  patch 'profile/edit', to: 'users#update'

  get 'dashboard', to: 'users#show'
  get 'dashboard/orders', to: 'orders#index'
  get 'dashboard/items', to: 'items#index'

  resources :sessions

  resources :items, only: [:index, :new, :create, :edit]


  resources :carts, only: [:index, :create]


  resources :users, only: [:index, :show, :destroy] do
    resources :orders, only: [:index]
  end


end
