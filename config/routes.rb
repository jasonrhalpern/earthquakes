Rails.application.routes.draw do
  root to: "home#index"

  resources :earthquakes do
    collection do
      get :search
    end
  end
end
