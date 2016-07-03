Rails.application.routes.draw do

  devise_for :users

  get '/about' => 'static_pages#about'

  # Require movings for accessing household items
  # in order to make household items private.
  resources :movings do
    resources :household_items, except: :show
  end

  root 'static_pages#home'
end
