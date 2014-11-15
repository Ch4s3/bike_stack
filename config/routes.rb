Rails.application.routes.draw do
  get 'lock_up/show'

  get 'lock_up/create'

  post 'lock_up/submit'

  get 'lock_up/index'

  get 'lock_up/spots', path: '/spots'

  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
