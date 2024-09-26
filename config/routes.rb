Rails.application.routes.draw do
  root 'links#index'
  resources :links do
    member do
      post 'upvote'
      post 'downvote'
    end
  end

  get 'login/:token', to: 'sessions#login', as: :login_token
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
