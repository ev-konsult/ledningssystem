Rails.application.routes.draw do
  get 'articles/show'

  get 'articles/new'

  resources :users do
    resources :educations, only: [:create]
  end

  resources :articles
  resources :tasks
  # resources :documents TODO fix file-stuf

  root to: "users#user_root"

  # Custom routes
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
