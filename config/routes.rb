Rails.application.routes.draw do
  devise_for :users

  resources :wikis
  resources :charges
  
  root 'welcome#index'
end
