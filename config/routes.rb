Rails.application.routes.draw do

  # To override Devise controllers.
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
                                    registrations: "registrations",
                                    confirmations: "confirmations" }

  get '/about' => 'static_pages#about'

  # Require movings for accessing household items
  # in order to make household items private.
  resources :movings do
    resources :household_items, except: :show
  end

  # To ask user for email after OmniAuth authentication.
  match '/users/:id/finish_signup' => 'users#finish_signup',
    via: [:get, :patch], as: :finish_signup

  resources :social_profiles, only: :destroy

  root 'static_pages#home'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
