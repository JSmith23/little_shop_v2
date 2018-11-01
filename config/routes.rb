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
  patch '/users/:id', to: 'users#upgrade', as: 'upgrade_user'
  get '/profile/edit/', to: 'users#edit'
  patch '/profile/edit/', to: 'users#update'
  get '/profile/orders', to: 'orders#index'
  delete '/profile/orders', to: 'orders#destroy'

  namespace :dashboard do
    resources :items, only: [:index]
    resources :orders, only: [:index]
  end

  get 'merchants', to: 'users#index'
  patch 'merchants/:id', to: 'users#downgrade', as: 'downgrade_merchant'
  get 'merchants/:id', to: 'dashboard#show', as: 'merchant'
  get 'merchants/:id/edit', to: 'users#edit', as: 'edit_merchant'
  get 'merchants/:id/orders', to: 'dashboard/orders#index', as: 'merchant_orders'
  get 'merchants/:id/items', to: 'dashboard/items#index', as: 'merchant_items'

  get '/dashboard', to: 'dashboard#show'

  resources :orders, only: [:show, :destroy, :index, :create] do
    resources :order_items, only: [:update]
  end

  resources :users, only: [:show, :update, :edit, :index, :destroy] do
    resources :orders, only: [:index, :destroy, :edit]
  end

  resources :items, only: [:show, :index, :new, :create, :edit, :update, :destroy]

  resources :carts, only: [:create]
  get "/cart", to: "carts#show"
  delete "/cart", to: "carts#destroy", as: :destroy_cart
  resources :line_items, only: [:destroy] do
    post :increment
    delete :decrement
  end

end
