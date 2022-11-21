Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :promotions
      resources :platforms
      resources :payments
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
