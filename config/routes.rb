Rails.application.routes.draw do
  get 'results/index'
  get 'results/show'
  get 'results/new'
  get 'results/create'
  get 'results/edit'
  get 'results/update'
  get 'results/destroy'
  get 'matchs/index'
  get 'matchs/show'
  get 'matchs/new'
  get 'matchs/create'
  get 'matchs/edit'
  get 'matchs/update'
  get 'matchs/destroy'
  get 'players/index'
  get 'players/show'
  get 'players/new'
  get 'players/create'
  get 'players/edit'
  get 'players/update'
  get 'players/destroy'
  get 'teams/index'
  get 'teams/show'
  get 'teams/new'
  get 'teams/create'
  get 'teams/edit'
  get 'teams/update'
  get 'teams/destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

    resources :teams
  
    resources :players
    
    resources :matches
    
    resources :results
end
