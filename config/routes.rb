Rails.application.routes.draw do

  devise_for :users

  get '/about' => 'static_pages#about'

  # List of household items is displayed in the movings#show page.
  get '/movings/:id/household_items' => 'movings#show'

  # Require movings for accessing household items
  # in order to make household items private.
  resources :movings do
    resources :household_items, only: [:new, :create, :edit, :update, :destroy]
  end

  root 'static_pages#home'
end
