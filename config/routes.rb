Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :courses do
    resources :lessons do 
      resources :completed_lessons, only: [:create, :destroy]
    end
    resources :enrollments, only: [:create, :destroy]
  end

  
end
