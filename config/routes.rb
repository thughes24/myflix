Myflix::Application.routes.draw do

  root 'static#landing_page'
  get 'ui(/:action)', controller: 'ui'
  resources :users, only: [:new,:create]
  get '/sign-in', to: 'sessions#sign_in', as: 'sign_in'
  post '/checking_credentials', to: 'sessions#checking_credentials'
  get '/logout', to: "sessions#logout"

  get "/home", to: "video#home"
  get "/category/:id", to: "category#show", as: 'show_category'
  resources :video, only: [:show] do
    collection do
      get :search
    end
  end 
end
