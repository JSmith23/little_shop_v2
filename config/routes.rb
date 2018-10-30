Rails.application.routes.draw do

  root 'welcome#index'

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'


  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/profile', to: 'users#show'
  get '/profile/edit/', to: 'users#edit'
  patch '/profile/edit/', to: 'users#update'
  get '/profile/orders', to: 'orders#index'
  delete '/profile/orders', to: 'orders#destroy'

  patch '/items/edit/', to: 'items#update'


  namespace :dashboard do
    resources :items, only: [:index]
    resources :orders, only: [:index, :edit]
  end

  get 'merchants', to: 'users#index'

  get '/dashboard', to: 'dashboard#show'

  resources :orders, only: [:show, :destroy, :index]

  resources :users, only: [:show, :update, :edit, :index, :destroy] do
    resources :orders, only: [:index, :destroy, :edit]
  end

  resources :sessions

  resources :items, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  resources :carts, only: [:create]
  get "/cart", to: "carts#show"
  delete "/cart", to: "carts#destroy", as: :destroy_cart
  resources :line_items, only: [:destroy] do
    post :increment
    delete :decrement
  end

end
