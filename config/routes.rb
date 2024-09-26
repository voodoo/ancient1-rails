Rails.application.routes.draw do
  root 'links#index'
  resources :links

  get 'login/:token', to: 'sessions#login', as: :login_token
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
