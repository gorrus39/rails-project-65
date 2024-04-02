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
      root 'bulletins#under_moderation'

      resources :bulletins, only: %i[index] do
        member do
          patch :publish
          patch :reject
          patch :archive
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end
    scope :auth, module: :auth do
      post :log_out, action: :log_out, as: :auth_log_out
      post ':provider', action: :request, as: :auth_request
      get ':provider/callback', action: :callback, as: :callback_auth
    end
  end
end
