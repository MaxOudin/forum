Rails.application.routes.draw do
  # resources :users
  # devise_for :users
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'users/registrations' }

  root "pages#home"
  get 'users/search', to: 'users#search'

  get "up" => "rails/health#show", as: :rails_health_check

  resources :articles do
    resource :cover_image, only: [:destroy], module: :articles
  end

  # delete 'articles/:id/remove_attachment/:attachment_id', to: 'articles#remove_attachment', as: 'remove_attachment'
  resources :organismes do
    get 'search_manager', on: :member
    member do
      get :org_project_managers_for_select, defaults: { format: :turbo_stream }
    end
  end
  resources :socials
  resources :projects do
    resources :organisme_projects, only: %i[new create edit update destroy]
  end
  resources :users
end
