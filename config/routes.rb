Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  get 'profile', to: 'users#show'

  get 'profile/edit', to: 'users#edit'
  patch 'profile/edit', to: 'users#update'
  
  resources :sessions

  resources :items, only: [:index]

  resources :users, only: [:index] do
    resources :orders, only: [:index]
  end


end
