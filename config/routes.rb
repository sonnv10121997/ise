Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  mount ActionCable.server => "/cable"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, module: :users, skip: :omniauth_callbacks
    resources :users, only: %i(show update index)
    resources :events, only: %i(index show)
    resources :user_enroll_events, except: %i(new edit), param: :event_id
    resources :user_event_requirements, only: %i(upload_image check_requirement) do
      member do
        patch "/", to: "user_event_requirements#upload_image"
        put "/", to: "user_event_requirements#check_requirement"
      end
    end
    resources :searches, only: :index
    resources :conversations, only: %i(create update) do
      resources :messages, only: %i(create destroy)
    end
    resources :partners, only: :show
    resources :notifications, only: %i(index create)
    resource :notifications, only: :update
    root "events#index"
  end
end
