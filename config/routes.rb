# frozen_string_literal: true

Rails.application.routes.draw do
  root 'web/bulletins#index'

  scope module: :web do
    resources :categories
    resources :bulletins
  end

  scope :auth do
    post 'log_out', to: 'web/auth#log_out', as: :auth_log_out
    post ':provider', to: 'web/auth#request', as: :auth_request
    get ':provider/callback', to: 'web/auth#callback', as: :callback_auth
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
