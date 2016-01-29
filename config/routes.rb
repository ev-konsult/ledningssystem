Rails.application.routes.draw do
  resources :users
  resources :news

  root to: 'sessions#new'

  # Custom routes
  get    'signup'  => 'developers#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
