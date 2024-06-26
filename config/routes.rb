Rails.application.routes.draw do
  devise_for :users

  resources :debts, except: %i(edit update show)
  resources :payments

  resources :people do
    collection do
      get :search
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Your::Application.routes.draw do
    
  # end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # No arquivo config/routes, adicione:
  get 'reports/balance'

  # Defines the root path route ("/")
  root 'dashboard#index'
  mount RailsPerformance::Engine, at: 'rails/performance'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
