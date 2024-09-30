Rails.application.routes.draw do
  root 'links#index'
  get 'links/best', to: 'links#best', as: :best_links
  resources :links do
    member do
      post 'upvote'
      post 'downvote'
    end
    resources :comments, only: [:create, :destroy, :new] do
      member do
        post 'upvote'
        post 'downvote'
      end
      get 'reply', on: :member
    end

  end
 

  get 'login/:token', to: 'sessions#login', as: :login_token
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
