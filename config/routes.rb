Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :subscriptions
      resources :customers do
        resources :subscriptions, only: :index
      end
    end
  end
end
