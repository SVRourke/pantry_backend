Rails.application.routes.draw do

  post '/login', to: 'auth#create'
  # delete '/logout', to: 'auth#destroy'
  
  resources :users, only: [:create, :show, :index] do
    resources :friendrequests, only: [:create, :update, :destroy] 
    resources :lists, only: [:create, :show, :index, :destroy]
  end
    
  resources :lists, only: [] do
    resources :list_invites, only: [:create, :update, :destroy] 
  end  

  post '/search', to: 'users#search'
  get '/user_info', to: 'users#profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# TODO: MOVE SIGN UP ACTION TO REGISTRATIONS CONTROLLER