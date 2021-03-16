Rails.application.routes.draw do

  post '/login', to: 'auth#create'
  # delete '/logout', to: 'auth#destroy'
  
  resources :users, only: [:create, :show, :index] do
     resources :lists, only: [:create, :show, :index]  
     resources :friendrequests, only: [:create, :update, :destroy] 
    end
    
  # resources :lists, only: [:destroy, :update] do
  #   resources :items, only: [:create, :show, :update, :destroy]
  # end
  
  post '/search', to: 'users#search'
  get '/user_info', to: 'users#profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# TODO: MOVE SIGN UP ACTION TO REGISTRATIONS CONTROLLER