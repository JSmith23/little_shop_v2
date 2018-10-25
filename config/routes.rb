Rails.application.routes.draw do
  root "welcome#index"
  get 'register', to: 'users#new', as: "register"
  get 'login', to: 'sessions#new', as: "login"
  get 'logout', to: 'sessions#destroy', as: "logout"


  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/profile/:id', to: 'users#show', as: 'profile'

  get '/profile/edit/:id', to: 'users#edit', as: 'edit_profile'
  patch '/profile/edit/:id', to: 'users#update'

  resources :sessions

  resources :items, only: [:index]

  resources :users, only: [:index, :new] do
    resources :orders, only: [:index]
  end


end
