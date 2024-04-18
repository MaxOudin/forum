Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { sessions: 'sessions' }

  root "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :articles do
    resource :cover_image, only: [:destroy], module: :articles
  end

  # delete 'articles/:id/remove_attachment/:attachment_id', to: 'articles#remove_attachment', as: 'remove_attachment'
  resources :organismes
  resources :socials

end
