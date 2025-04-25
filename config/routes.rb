Rails.application.routes.draw do
  mount Prettytodo::Engine => "/project_todos"
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "pages#home"

  resources :users
  resources :todos, only: [ :index ]
  resources :categories, only: [ :create, :update, :destroy ]
end
