Rails.application.routes.draw do
  resources :todo_lists do
    resources :todos
  end

  resources :users

  resources :expense_lists do
    resources :expenses
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  get 'contact' => 'static_pages#contact'
  get 'home' => 'static_pages#home'

  root 'static_pages#home'
end
