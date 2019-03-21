Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, module: :users, skip: :omniauth_callbacks
    resources :users, only: :show
    resources :events, only: %i(index show)
    resources :user_enroll_events, only: %i(show create destroy), param: :event_id
    # get "/user_enroll_event/:event_id", to: "user_enroll_events#show", as: "user_enroll_event"
    # post "/user_enroll_event/:event_id", to: "user_enroll_events#create", as: "enroll_event"
    # delete "/user_enroll_event/:event_id", to: "user_enroll_events#destroy", as: "unenroll_event"
    root "events#index"
  end
end
