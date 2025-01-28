Rails.application.routes.draw do
  root to: 'courses#index'
  devise_for :users
  resource :profile, only: [:show, :new, :create, :edit, :update]
  
  get "up" => "rails/health#show", as: :rails_health_check

  resources :categories do
    resources :courses, only: [:index, :show]
  end

  resources :courses do
    resources :lessons do 
      resources :completed_lessons, only: [:create, :destroy]
    end
    resources :enrollments, except: [:edit, :update, :new]
 
    member do
      get 'certificate', to: 'certificates#show', as: 'certificate'
    end
  end
end
