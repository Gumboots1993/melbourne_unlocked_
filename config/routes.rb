Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}
  root to: 'locks#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'locks/new-lock-request', to: 'locks#new_lock'
  get 'locks/view-requests', to: 'locks#view_requests'

  resources :locks do
    resources :visits, only: [:create]
  end

  resources :visits, only: [:edit, :update, :show] do
    resources :reviews, only: [:new, :create]
  end

  get 'profile/:username', to: 'pages#profile', as: :profile
  get 'leaderboard', to: 'pages#leaderboard', as: :leaderboard
  get 'locks/new', to: 'locks#new'
  patch 'locks/:id/accept', to: 'locks#accept', as: :accept_lock
  patch 'locks/:id/decline', to: 'locks#decline', as: :decline_lock
  get 'notifications/:username', to: 'notifications#index', as: :notifications

end
