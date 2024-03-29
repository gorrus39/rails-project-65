# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    scope module: :profile do
      get 'profile', to: 'bulletins#index'
      resources :bulletins, only: %i[new create edit update destroy]
    end

    namespace :admin do
      root 'bulletins#under_moderation', to: 'bulletins#under_moderation'
      # putch ''
      resources :bulletins, only: %i[index]
      # get 'bulletins', to: 'bulletins#index'
      get 'categories', to: 'categories#index'
    end
  end

  scope :auth do
    post 'log_out', to: 'web/auth#log_out', as: :auth_log_out
    post ':provider', to: 'web/auth#request', as: :auth_request
    get ':provider/callback', to: 'web/auth#callback', as: :callback_auth
  end

  resources :categories
  resources :bulletins, only: %i[show]
  root 'web/bulletins#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
