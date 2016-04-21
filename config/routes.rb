Rails.application.routes.draw do
  resources :users

  resources :expense_lists do
    resources :expenses
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  root 'expense_lists#index'
end
