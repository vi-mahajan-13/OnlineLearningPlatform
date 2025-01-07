Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'home#index'
  
  resources :courses do
    resources :lessons
  end
end
