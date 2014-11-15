Rails.application.routes.draw do
  resources :lock_ups
  post 'lock_ups/find'

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users

  namespace :api do
    resources :spots
    post 'spots/find'
  end
end
