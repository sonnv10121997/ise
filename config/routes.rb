Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, module: :users, skip: :omniauth_callbacks
    post "/user_follow_event/:event_id", to: "user_follow_event#create", as: "follow_event"
    delete "/user_follow_event/:event_id", to: "user_follow_event#destroy", as: "unfollow_event"
    resources :users, only: :show
    resources :events, only: %i(index show)
    resources :user_enroll_events, only: :show, param: :event_id
    root "events#index"
  end
end
