Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'pages#main'

  get '/elections/e/:id', to: "elections#get_by_custom_url"

  resources :elections

  resources :voters

  post '/login', action: :create, controller: 'sessions'

end
