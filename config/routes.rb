Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, module: :users, skip: :omniauth_callbacks
    resources :users, only: :show
    resources :events, only: %i(index show)
    resources :user_enroll_events, only: %i(show create destroy), param: :event_id
    resources :user_event_requirements, only: :update
    root "events#index"
  end
end
