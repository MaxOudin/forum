Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  root "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  post 'locale', to: 'application#set_locale', as: :locale

  resources :articles do
    resource :cover_image, only: [:destroy], module: :articles
    resources :comments
  end
  resources :organismes
  resources :socials
end
