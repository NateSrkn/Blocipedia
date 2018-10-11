Rails.application.routes.draw do
  devise_for :users

  resources :wikis
  resources :charges

  post 'charges/cancel'
  
  root 'wikis#index'
end
