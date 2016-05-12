Rails.application.routes.draw do
  # resources :users

  resources :expense_lists do
    resources :expenses
  end

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  get '/logout' => 'sessions#destroy'

  get 'contact' => 'static_pages#contact'
  get 'home' => 'static_pages#home'

  get '/admin' => 'users#admin'

  root 'static_pages#home'
end
