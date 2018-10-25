Rails.application.routes.draw do
  devise_for :users

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end
  resources :charges

  post 'charges/cancel'
  
  root 'wikis#index'
end
