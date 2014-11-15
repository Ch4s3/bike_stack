Rails.application.routes.draw do
  resources :lockups
  
  post 'lock_up/submit'

  get 'lock_up/spots', path: '/spots'

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
