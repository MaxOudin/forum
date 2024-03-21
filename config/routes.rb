Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  resources :articles do
    resource :cover_image, only: [:destroy], module: :articles
  end
  # delete 'articles/:id/remove_attachment/:attachment_id', to: 'articles#remove_attachment', as: 'remove_attachment'

end
