Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get "/home", to: "video#home"
  get "/video/:id", to: "video#show", as: 'show_video'
  get "/category/:id", to: "category#show", as: 'show_category'
end
