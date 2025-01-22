Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :schedules, only: [:index, :show] do
        resources :shows, only: [:destroy], controller: "schedule_shows"
      end
      resources :attendees, only: [:index, :show] do
        resources :schedules, only: [:index], to: "attendees#show"
      end
    end
  end
end
