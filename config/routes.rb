# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    resources :bulletins do
      member do
        patch :archive
        patch :to_moderate
      end
    end

    resource :profile, only: %i[show]

    namespace :admin do
      root 'bulletins#index', filter: :under_moderation

      resources :bulletins, only: %i[index], filter: :all do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end
    scope :auth, module: :auth do
      post :logout, action: :logout, as: :auth_logout
      post ':provider', action: :request, as: :auth_request
      get ':provider/callback', action: :callback, as: :callback_auth
    end
  end
end
