Rails.application.routes.draw do
  resources :lock_ups
  post 'lock_ups/find'
  post 'lock_ups/vote'

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  namespace :api do
    resources :spots
    post 'spots/find'
    post 'spots/vote'
  end
end
