Rails.application.routes.draw do
  resources :lock_ups
  
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users

  namespace :api do
    resources :spots
  end
end
