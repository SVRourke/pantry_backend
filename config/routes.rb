Rails.application.routes.draw do

  post '/login', to: 'auth#create'
  # delete '/logout', to: 'auth#destroy'
  
  resources :users, only: [:create, :show, :index] do
    resources :friendships, path: :friends, only: [:index, :destroy]
    resources :friendrequests, only: [:index, :create, :update, :destroy] 
    resources :lists, only: [:create, :show, :index, :destroy]
    resources :list_invites, only: [:index]
  end
  
  resources :lists, only: [] do
    resources :list_invites, only: [:create, :update, :destroy] 
    resources :items, only: [:index, :show, :create, :destroy] do
      put :update
      patch :acquire
    end
    delete '/leave', to: "lists#leave"
  end  

  post '/search', to: 'users#search'
  get '/user_info', to: 'users#profile'
end

# TODO: MOVE SIGN UP ACTION TO REGISTRATIONS CONTROLLER