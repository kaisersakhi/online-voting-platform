Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'pages#main'


  get '/elections/e/:name', to: "elections#get_by_custom_url", as: :custom
  get '/elections/drafts', to: 'elections#show_draft_elections', as: :drafts
  get '/elections/drafts/edit/:id', to: 'elections#edit_draft', as: :edit_draft
  get '/elections/active', to: "elections#active_elections", as: :active_election
  get '/elections/archived', to: 'elections#archived', as: :archived_election
  patch '/elections/:id/launch', to: 'elections#launch', as: :launch_election
  patch '/elections/:id/end', to: 'elections#end', as: :end_election
  resources :elections


  # This route will be used to post new questions in an election
  get 'election/:e_id/question/:q_id/edit', to: 'elections#edit_question', as: :edit_question_of
  post '/election/:id/question', to: "elections#add_question", as: :add_question # notice 's'
  delete '/election/:e_id/question/:q_id', to: 'elections#destroy_question', as: :delete_question
  patch '/election/:e_id/question/:q_id', to: 'elections#update_question', as: :update_question


  resources :voters
  get '/vote/:e_id', to: 'questions#show'
  patch '/vote/:e_id', to: 'questions#update_option', as: :vote



  get '/admin/dashboard', to: 'admins#dashboard', as: :admin_dashboard
  get '/admin/register', to: 'admins#new'
  post '/admin/register', to: 'admins#create' , as: :new_admin
  get '/admin/login', to: 'admins#login'


  get '/login', to: 'sessions#new', as: :new_login
  post '/login', to: 'sessions#create', as: :login
  delete '/logout', to: 'sessions#destroy', as: :logout



  # resources :targets, only: [] do
  #   member do
  #     get 'content'
  #     get 'details'
  #     get 'versions'
  #   end
  # end

end
