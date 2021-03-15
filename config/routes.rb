Rails.application.routes.draw do
  get 'private/test'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resource :lists
  # resources :list_invites
  # resources :items
  # resources :contributions
  # resources :lists
  # resources :friendrequests
  # resources :friendships
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  # Create Authenticated and unauthenticated routes
#   unauthenticated do
#     root :to => 'home#index'
#  end

#  authenticated do
#  end
end
