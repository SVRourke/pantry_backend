Rails.application.routes.draw do

  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'
  post '/auth_check', to: 'auth#check_auth'
  
  resources :users, only: [:create, :show, :index] do
    resources :friendships, path: :friends, only: [:index, :destroy]
    resources :friendrequests, only: [:index, :create, :update, :destroy] do
      patch :accept
    end 
    resources :lists, only: [:create, :show, :index, :destroy]
    resources :list_invites, only: [:index, :destroy] do
      patch :accept
    end
  end
  
  resources :lists, only: [] do
    resources :list_invites, only: [:create, :update]
    resources :contributions, only: [:index]
    resources :items, only: [:index, :show, :create, :destroy] do
      put :update
      patch :acquire
    end
    delete '/leave', to: "lists#leave"
  end  

  get '/user_info', to: 'users#profile'
end

# TODO: MOVE SIGN UP ACTION TO REGISTRATIONS CONTROLLER