Rails.application.routes.draw do
  resources :real_states, only: [ :index, :show ]

  devise_for :users

  namespace :admin do
    resources :users
    resources :buildings, only: [ :index, :new, :create, :show, :edit, :update, :destroy ]
    resources :common_rooms, only: [ :new, :create, :show, :edit, :update ]
    resources :units, only: [ :new, :create, :show, :edit, :update, :destroy ]
    resources :real_states, only: [ :new, :create, :index, :show, :edit, :update, :destroy ]
  end



  resources :user_profile, only: [ :show, :edit, :update ]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  get 'up' => 'rails/health#show', as: :rails_health_check
  root to: 'home#home'

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
