Rails.application.routes.draw do
  devise_for :users
  resources :list_invites
  resources :items
  resources :contributions
  resources :lists
  resources :friendrequests
  resources :friendships
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
