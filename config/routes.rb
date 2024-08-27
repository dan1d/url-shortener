Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  # resources :urls, only: %i[create show]
  post "/url", to: "urls#create"
  get "/url/:id", to: "urls#show"
  get "/urls", to: "urls#index"
end
