Myflix::Application.routes.draw do

  root 'static#landing_page'
  get 'ui(/:action)', controller: 'ui'
  resources :users, only: [:new,:create,:show] do
    resources :follows, only: [:create, :destroy]
  end
  get "/people", to: "users#people", as: 'people'
  get '/sign-in', to: 'sessions#sign_in', as: 'sign_in'
  post '/sign-in', to: 'sessions#checking_credentials'
  get '/logout', to: "sessions#logout"
  get '/my_queue', to: "queue_items#index"
  resources :queue_items, only: [:create, :destroy]
  post '/my_queue', to: "queue_items#update_queue", as: 'update_queue'

  get "/home", to: "videos#home"
  get "/category/:id", to: "category#show", as: 'show_category'
  resources :videos, only: [:show] do
    resources :reviews, only: :create
    collection do
      get :search
    end
  end 

  get '/password-reset', to: 'users#password_reset', as: 'password_reset'
  get '/confirm-password-reset', to: 'users#confirm_password_reset', as: 'confirm_password_reset'
  get '/new-password', to: "users#new_password", as: 'new_password'
  get '/invalid-token', to: "users#invalid_token", as: 'invalid_token'
  post '/create-password',to: 'users#create_password', as: 'create_password'

  resources :invites, only: [:new,:create]
end
