Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get '/about' => 'static_pages#about'

  resources :movings do
    resources :household_items
  end
end
