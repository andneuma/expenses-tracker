Rails.application.routes.draw do
  resources :expense_lists do
    resources :expenses
  end

  root 'expense_lists#index'

  end
