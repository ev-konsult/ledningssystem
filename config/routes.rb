Rails.application.routes.draw do
  get 'articles/show'

  get 'articles/new'

  resources :users do
    resources :educations, only: [:create]
  end
  resources :articles

  root to: 'sessions#new'

  # Custom routes
  get    'signup'  => 'developers#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
