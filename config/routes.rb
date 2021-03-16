Rails.application.routes.draw do
  # resources :list_invites

  # resources :items
  # resources :contributions
  # resources :lists
  # resources :friendrequests
  # resources :friendships
  # resources :users
  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'
  
  resources :users, only: [:create, :show, :index] do
     resources :lists, only: [:create, :show, :index]  
     resources :friendrequests, only: [:create] 
    end
    
    resources :friendrequests, only: :accept do
      patch 'accept'
    end
  # resources :lists, only: [:destroy, :update] do
  #   resources :items, only: [:create, :show, :update, :destroy]
  # end
  
  post '/search', to: 'users#search'
  get '/user_info', to: 'users#profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# TODO: MOVE SIGN UP ACTION TO REGISTRATIONS CONTROLLER