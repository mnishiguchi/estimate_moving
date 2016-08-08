Rails.application.routes.draw do

  root "static_pages#home"
  get "/about" => "static_pages#about"

  scope :admin do
    resources :default_volumes
  end

  devise_for :admins, controllers: {
    sessions:           "admins/sessions"
  }
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions:           "users/sessions",
    passwords:          "users/passwords",
    registrations:      "users/registrations",
    confirmations:      "users/confirmations"
  }

  # Require movings for accessing household items
  # in order to make household items private.
  resources :movings do
    resources :household_items, except: :show
  end

  # To ask user for email after OmniAuth authentication.
  match "/users/:id/finish_signup" => "users#finish_signup",
    via: [:get, :patch], as: :finish_signup

  resources :social_profiles, only: :destroy

  # For viewing delivered emails in development environment.
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
