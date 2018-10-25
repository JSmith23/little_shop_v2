Rails.application.routes.draw do

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/profile/:id', to: 'users#show', as: 'profile'

  get '/profile/edit/:id', to: 'users#edit', as: 'edit_profile'
  patch '/profile/edit/:id', to: 'users#update'

  resources :items, only: [:index]

  resources :users, only: [:index] do
    resources :orders, only: [:index]
  end


end
