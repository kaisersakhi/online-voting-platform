Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'pages#main'


  get '/elections/e/:id', to: "elections#get_by_custom_url"
  get '/elections/drafts', to: 'elections#show_draft_elections'
  get '/elections/drafts/edit/:id', to: 'elections#edit_draft'
  resources :elections

  # This route will be used to post new questions in an election
  get 'election/:e_id/question/:q_id/edit', to: 'questions#edit'
  # get 'election/:e_id/question', to: "questions#all_questions"
  post '/election/:id/question', to: "questions#add_question" # notice 's'
  delete '/election/:e_id/question/:q_id', to: 'questions#destroy'
  patch 'election/:e_id/question/:q_id', to: 'questions#update'


  resources :voters

  post '/login', action: :create, controller: 'sessions'

  get '/admin/dashboard', to: 'pages#admin_dashboard'

end
