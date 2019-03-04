Rails.application.routes.draw do
  devise_for :users, module: :users

  devise_scope :user do
    root "users/sessions#new"
  end

  # get "*pages", to: "errors#routing"
end
