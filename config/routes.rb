Rails.application.routes.draw do
  root 'links#index'
  get 'links/best', to: 'links#best', as: :best_links
  resources :links do
    resources :comments, only: [:create, :destroy, :new] do
      get 'reply', on: :member
    end
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
