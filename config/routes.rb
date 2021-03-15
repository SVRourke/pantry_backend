Rails.application.routes.draw do
  # resources :list_invites

  # resources :items
  # resources :contributions
  # resources :lists
  # resources :friendrequests
  # resources :friendships
  # resources :users
  resources :users, only: [:create, :show]
  post '/login', to: 'sessions#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# TODO: MOVE SIGN UP ACTION TO REGISTRATIONS CONTROLLER