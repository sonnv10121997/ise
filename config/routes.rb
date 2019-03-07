Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, module: :users, skip: :omniauth_callbacks
    resources :events
    root "events#index"
  end
end
