Rails.application.routes.draw do
  root "dashboard#index"
  get 'dashboard/index'

  resources :teams
  resources :players
  resources :results
  resources :matches do
    member do
      get :teams
      post :start
    end
    resources :results, only: [:new, :create]
  end
  
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
